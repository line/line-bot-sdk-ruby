module Line
  module Bot
    module Utils

      # @return [Boolean]
      def validate_mids(mids)
        return false unless mids.is_a?(String) || mids.is_a?(Array)
        mids = [mids] if mids.is_a?(String)

        return false unless mids.size > 0

        true
      end
    end
  end
end
