module Line
  module Bot
    module Utils

      # @return [Boolean]
      def validate_mids(mids)
        return false unless mids.instance_of?(String) || mids.instance_of?(Array)
        mids = [mids] if mids.instance_of?(String)

        return false unless mids.size > 0 && mids.all? {|item| item.instance_of?(String)}

        true
      end
    end
  end
end
