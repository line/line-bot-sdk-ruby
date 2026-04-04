# frozen_string_literal: true

module UnifiedClientGenerator
  module_function

  def discover_clients(root)
    clients = Dir[root.join('sig/line/bot/v2/*/api/*_client.rbs').to_s].sort.filter_map do |sig_path|
      pkg = Pathname(sig_path).relative_path_from(root.join('sig/line/bot/v2')).each_filename.first
      next if EXCLUDED_PACKAGES.include?(pkg)

      rb_path = root.join('lib/line/bot/v2', pkg, 'api', File.basename(sig_path, '.rbs') + '.rb')
      raise "Missing Ruby client for #{sig_path}" unless rb_path.exist?

      parse_client(sig_path: Pathname(sig_path), rb_path: rb_path)
    end
    clients.sort_by { |c| [c.package_dir, c.delegate_name] }
  end

  def parse_client(sig_path:, rb_path:)
    declarations = RBS::Parser.parse_signature(
      RBS::Buffer.new(name: sig_path.to_s, content: sig_path.read)
    ).last

    component_module = dig_module(declarations, :Line, :Bot, :V2)
    klass = component_module.members.grep(RBS::AST::Declarations::Class).first or
      raise "Missing class in #{component_module.name.name}"

    init = klass.members.grep(RBS::AST::Members::MethodDefinition).find { |m| m.name == :initialize } or
      raise "Missing initialize in #{sig_path}"
    ctor = init.overloads.fetch(0).method_type.type

    ns = component_module.name.name.to_s
    models = collect_model_names(klass)

    ClientSpec.new(
      package_dir: sig_path.relative_path_from(sig_path.parent.parent.parent).each_filename.first,
      namespace_name: ns,
      class_name: klass.name.name.to_s,
      delegate_name: File.basename(sig_path, '.rbs').sub(/_client\z/, ''),
      default_base_url: parse_default_base_url(rb_path.read, rb_path),
      constructor_required_keywords: ctor.required_keywords.keys.map(&:to_s),
      constructor_optional_keywords: ctor.optional_keywords.keys.map(&:to_s),
      delegated_methods: klass.members.grep(RBS::AST::Members::MethodDefinition).filter_map do |m|
        next if m.name == :initialize

        build_method_spec(m, ns, models)
      end,
      model_names: models
    )
  end

  def dig_module(declarations, *names)
    node = declarations.find { |d| d.is_a?(RBS::AST::Declarations::Module) && d.name.name == names.first } or
      raise "Missing #{names.first} module"
    names.drop(1).each do |name|
      node = node.members.find { |m| m.is_a?(RBS::AST::Declarations::Module) && m.name.name == name } or
        raise "Missing #{name} module"
    end
    node.members.find { |m| m.is_a?(RBS::AST::Declarations::Module) } or
      raise "Missing component module under V2"
  end

  def collect_model_names(klass)
    names = Set[]
    klass.members.grep(RBS::AST::Members::MethodDefinition).each do |member|
      member.overloads.each do |ol|
        walk_type(ol.method_type.type) do |t|
          next unless t.is_a?(RBS::Types::ClassInstance) && t.name.namespace.empty?

          n = t.name.name.to_s
          names << n unless BUILTINS.include?(n)
        end
      end
    end
    names
  end

  def walk_type(type, &block)
    yield(type)
    case type
    when RBS::Types::Function
      [*type.required_keywords.each_value, *type.optional_keywords.each_value,
       *type.required_positionals, *type.optional_positionals, *type.trailing_positionals].each { |p| walk_type(p.type, &block) }
      walk_type(type.rest_positionals.type, &block) if type.rest_positionals
      walk_type(type.rest_keywords.type, &block) if type.rest_keywords
      walk_type(type.return_type, &block)
    when RBS::Types::Union, RBS::Types::Tuple
      type.types.each { |child| walk_type(child, &block) }
    when RBS::Types::Optional
      walk_type(type.type, &block)
    when RBS::Types::ClassInstance
      type.args.each { |child| walk_type(child, &block) }
    end
  end

  def build_method_spec(member, ns, models)
    ft = member.overloads.fetch(0).method_type.type
    raise "Positional args not supported: #{member.name}" unless
      ft.required_positionals.empty? && ft.optional_positionals.empty? &&
      ft.trailing_positionals.empty? && ft.rest_positionals.nil?
    raise "Rest keywords not supported: #{member.name}" if ft.rest_keywords

    MethodSpec.new(
      name: member.name.to_s,
      comment: qualify_comment(member.comment&.string.to_s, ns, models),
      required_keywords: ft.required_keywords.transform_values { |p| rbs_type(p.type, ns, models) },
      optional_keywords: ft.optional_keywords.transform_values { |p| rbs_type(p.type, ns, models) },
      return_type: rbs_type(ft.return_type, ns, models)
    )
  end

  def rbs_type(type, ns, models)
    case type
    when RBS::Types::Bases::Any then 'untyped'
    when RBS::Types::Bases::Bool then 'bool'
    when RBS::Types::Bases::Void then 'void'
    when RBS::Types::Literal then type.literal.inspect
    when RBS::Types::Optional then "#{rbs_type(type.type, ns, models)}?"
    when RBS::Types::Union
      type.types.map { |c| rbs_type(c, ns, models) }.uniq.join(' | ')
    when RBS::Types::Tuple
      "[#{type.types.map { |c| rbs_type(c, ns, models) }.join(', ')}]"
    when RBS::Types::ClassInstance
      name = rbs_type_name(type.name, ns, models)
      type.args.empty? ? name : "#{name}[#{type.args.map { |c| rbs_type(c, ns, models) }.join(', ')}]"
    else
      raise "Unsupported RBS type: #{type.class}"
    end
  end

  def rbs_type_name(type_name, ns, models)
    if type_name.namespace.empty?
      n = type_name.name.to_s
      return n if BUILTINS.include?(n)
      return "Line::Bot::V2::#{ns}::#{n}" if models.include?(n)

      n
    else
      [*type_name.namespace.path.map(&:to_s), type_name.name.to_s].join('::')
    end
  end

  # Extracts the default base URL from a generated ApiClient Ruby source.
  #
  # All generated clients follow the pattern:
  #   @http_client = HttpClient.new(
  #     base_url: base_url || 'https://api.line.me',
  #     ...
  #   )
  def parse_default_base_url(source, path)
    source = source.encode('UTF-8', invalid: :replace, undef: :replace)
    match = source.match(/HttpClient\.new\([^)]*base_url:\s*base_url\s*\|\|\s*['"]([^'"]+)['"]/m)
    raise "Could not determine default base_url for #{path}" unless match

    match[1]
  end
end
