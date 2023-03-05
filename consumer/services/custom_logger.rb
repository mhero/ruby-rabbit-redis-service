# frozen_string_literal: true

module CustomLogger
  class Log
    @logger ||= Logger.new(STDOUT)

    class << self
      def error_message(message, error)
        @logger.error "#{message} \
                        #{error}"
      end

      def info(message)
        @logger.info "#{message} "
      end
    end
  end
end
