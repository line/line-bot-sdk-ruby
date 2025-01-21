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
      end
    end
  end
end
