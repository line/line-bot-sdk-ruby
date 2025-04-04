module Line
  module Bot
    module V2
      module Utils
        def self.deep_underscore(hash)
          hash.each_with_object({}) do |(key, value), result|
            # Convert key to string if it's a symbol, then apply the regex
            new_key = key.to_s.gsub(/([A-Z\d]+)([A-Z][a-z])|([a-z\d])([A-Z])/, '\1\3_\2\4').downcase.to_sym
            new_value = if value.is_a?(Hash)
                          deep_underscore(value)
                        elsif value.is_a?(Array)
                          value.map { |v| v.is_a?(Hash) ? deep_underscore(v) : v }
                        else
                          value
                        end
            result[new_key] = new_value
          end
        end

        def self.deep_symbolize(object)
          case object
          when Hash
            object.each_with_object({}) do |(key, value), new_hash|
              sym_key = key.is_a?(String) ? key.to_sym : key
              new_hash[sym_key] = deep_symbolize(value)
            end
          when Array
            object.map { |element| deep_symbolize(element) }
          else
            object
          end
        end

        def self.deep_to_hash(object)
          if object.is_a?(Array)
            object.map { |item| deep_to_hash(item) }
          elsif object.is_a?(Hash)
            object.transform_keys(&:to_sym).transform_values { |v| deep_to_hash(v) }
          elsif object.instance_variables.empty?
            object
          else
            object.instance_variables.each_with_object({}) do |var, hash|
              value = object.instance_variable_get(var)
              key = var.to_s.delete('@').to_sym
              hash[key] = deep_to_hash(value)
            end
          end
        end

        def self.deep_camelize(object)
          case object
          when Array
            object.map { |item| deep_camelize(item) }
          when Hash
            object.each_with_object({}) do |(k, v), new_object|
              camel_key = camelize(k).to_sym
              new_value = v.is_a?(Array) || v.is_a?(Hash) ? deep_camelize(v) : v
              new_object[camel_key] = new_value
            end
          else
            object
          end
        end

        def self.deep_compact(object)
          case object
          when Hash
            object.each_with_object({}) do |(k, v), new_hash|
              new_value = deep_compact(v)
              new_hash[k] = new_value unless new_value.nil? || (new_value.respond_to?(:empty?) && new_value.empty?)
            end
          when Array
            object.map { |item| deep_compact(item) }.compact
          else
            object
          end
        end

        def self.deep_convert_reserved_words(object)
          case object
          when Hash
            object.each_with_object({}) do |(key, value), new_hash|
              new_key = if Line::Bot::V2::RESERVED_WORDS.include?(key.to_sym)
                          "_#{key}"
                        else
                          key
                        end
              new_hash[new_key] = deep_convert_reserved_words(value)
            end
          when Array
            object.map { |element| deep_convert_reserved_words(element) }
          else
            object
          end
        end

        def self.hash_to_struct(hash)
          struct_klass = Struct.new(*hash.keys.map(&:to_sym))
          struct_values = hash.map { |_k, v| v.is_a?(Hash) ? hash_to_struct(v) : v }
          struct_klass.new(*struct_values)
        end

        def self.camelize(str)
          str.to_s.split('_').inject { |memo, word| memo + word.capitalize }
        end
      end
    end
  end
end
