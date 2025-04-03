require 'json'
require 'openssl'

require 'line/bot/v2/reserved_words'
require 'line/bot/v2/messaging_api/core'
require 'line/bot/v2/webhook/core'

module Line
  module Bot
    module V2
      class WebhookParser
        class InvalidSignatureError < StandardError; end

        def initialize(channel_secret:)
          @channel_secret = channel_secret
        end

        def parse(body, signature)
          raise InvalidSignatureError.new("Invalid signature: #{signature}") unless verify_signature(body: body, signature: signature)

          data = JSON.parse(body.chomp, symbolize_names: true)
          data = Line::Bot::V2::Utils.deep_underscore(data)

          data[:events].map do |event|
            event_class_name = determine_class_name(:events, event)
            event_class = begin
              Object.const_get(event_class_name)
            rescue StandardError
              nil
            end

            # If there is no specific webhook class, leave the value as is
            event_instance = event_class ? create_instance(event_class, event) : event

            deep_hash_to_struct(event_instance)
          end
        end

        private

        def verify_signature(body:, signature:)
          hash = OpenSSL::HMAC.digest(OpenSSL::Digest.new('SHA256'), @channel_secret, body)
          expected = Base64.strict_encode64(hash)
          variable_secure_compare(signature, expected)
        end

        # To avoid timing attacks
        def variable_secure_compare(a, b)
          secure_compare(::Digest::SHA256.hexdigest(a), ::Digest::SHA256.hexdigest(b))
        end

        def secure_compare(a, b)
          return false unless a.bytesize == b.bytesize

          l = a.unpack("C#{a.bytesize}")

          res = 0
          b.each_byte { |byte| res |= byte ^ l.shift }
          res == 0
        end

        def create_instance(klass, attributes)
          keyword_args = {}

          attributes.each do |key, value|
            if value.is_a?(Hash)
              nested_class_name = determine_class_name(key, value)
              if nested_class_name
                nested_klass = Object.const_get(nested_class_name)
                value = create_instance(nested_klass, value)
              end
            elsif value.is_a?(Array)
              value = value.map do |item|
                nested_class_name = determine_class_name(key, item)
                if nested_class_name
                  nested_klass = Object.const_get(nested_class_name)
                  create_instance(nested_klass, item)
                else
                  item
                end
              end
            end

            # CodeGen add _ prefix to reserved words
            # see: https://github.com/OpenAPITools/openapi-generator/blob/master/modules/openapi-generator/src/main/java/org/openapitools/codegen/languages/AbstractRubyCodegen.java
            if Line::Bot::V2::RESERVED_WORDS.include?(key)
              keyword_args["_#{key}".to_sym] = value
            else
              keyword_args[key] = value
            end
          end

          begin
            klass.new(**keyword_args)
          rescue ArgumentError => e
            attributes # Return the original hash if unknown keyword error occurs
          end
        end

        # TODO: Derive classes from rbs information or define attribute/class mappings for each class and derive classes from them.
        def determine_class_name(key, value)
          class_name = if key == :events && value.is_a?(Hash) && value[:type] == 'delivery'
                         'PnpDeliveryCompletionEvent'
                       elsif key == :message && value.is_a?(Hash) && value[:type]
                         pascalize(value[:type]) + 'MessageContent'
                       elsif key == :mentionees && value.is_a?(Hash) && value[:type]
                         pascalize(value[:type]) + 'Mentionee'
                       elsif key == :module && value.is_a?(Hash) && value[:type]
                         pascalize(value[:type]) + 'ModuleContent'
                       elsif key == :things && value.is_a?(Hash) && value[:type]
                         pascalize(value[:type]) + 'ThingsContent'
                       elsif value.is_a?(Hash) && value[:type] && ['user', 'group', 'room'].include?(value[:type])
                         pascalize(value[:type]) + 'Source'
                       elsif key == :result && value.is_a?(Hash) && value[:result_code]
                         'ScenarioResult'
                       elsif key == :content_provider # This has type, but there is no typed ContentProvider
                         'ContentProvider'
                       elsif key == :_module # This has type, but there is no typed ModuleContent
                         'ModuleContent'
                       elsif key == :unsend
                         'UnsendDetail'
                       elsif key == :follow
                         'FollowDetail'
                       elsif key == :joined
                         'JoinedMembers'
                       elsif key == :left
                         'LeftMembers'
                       elsif key == :postback
                         'PostbackContent'
                       elsif key == :beacon
                         'BeaconContent'
                       elsif key == :link
                         'LinkContent'
                       elsif key == :delivery
                         'PnpDelivery'
                       elsif value.is_a?(Hash) && value[:type] # Event etc.
                         pascalize(value[:type]) + singularize(pascalize(key))
                       elsif value.is_a?(Array) && key.to_s.end_with?('s')
                         pascalize(singularize(key))
                       else
                         singularize(pascalize(key))
                       end

          full_class_name = "Line::Bot::V2::Webhook::#{class_name}"
          Object.const_defined?(full_class_name) ? full_class_name : nil
        end

        def pascalize(str)
          str.to_s.gsub(/(?:^|_)([a-z])/) { ::Regexp.last_match(1).upcase }
        end

        def singularize(str)
          str = str.to_s

          if str.end_with?('ies')
            str.sub(/ies$/, 'y')
          elsif str.end_with?('ves')
            str.sub(/ves$/, 'f')
          elsif str.end_with?('oes') || str.end_with?('xes') || str.end_with?('ses')
            str.sub(/es$/, '')
          elsif str.end_with?('s')
            str.sub(/s$/, '')
          else
            str
          end
        end

        def deep_hash_to_struct(obj)
          case obj
          when Hash
            keys = obj.keys.map(&:to_sym)
            struct_class = Struct.new(*keys)
            struct_class.new(*obj.values.map { |value| deep_hash_to_struct(value) })
          when Array
            obj.map { |item| deep_hash_to_struct(item) }
          else
            if obj.respond_to?(:instance_variables)
              obj.instance_variables.each do |var|
                value = obj.instance_variable_get(var)
                if value.is_a?(Hash) || value.is_a?(Array) || value.respond_to?(:instance_variables)
                  obj.instance_variable_set(var, deep_hash_to_struct(value))
                end
              end
            end
            obj
          end
        end
      end
    end
  end
end
