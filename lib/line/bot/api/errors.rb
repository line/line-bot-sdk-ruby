module Line
  module Bot
    module API
      class Error < StandardError; end
      class InvalidCredentialsError < Error; end
    end
  end
end
