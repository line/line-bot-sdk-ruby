module Line
  module Bot
    module V2
      # CodeGen add _ prefix to reserved words
      # see: https://github.com/OpenAPITools/openapi-generator/blob/master/modules/openapi-generator/src/main/java/org/openapitools/codegen/languages/AbstractRubyCodegen.java
      RESERVED_WORDS = %i[
        __FILE__
        and
        def
        end
        in
        or
        self
        unless
        __LINE__
        begin
        defined?
        ensure
        module
        redo
        super
        until
        BEGIN
        break
        do
        false
        next
        rescue
        then
        when
        END
        case
        else
        for
        nil
        retry
        true
        while
        alias
        class
        elsif
        if
        not
        return
        undef
        yield
      ]
    end
  end
end
