# frozen_string_literal: true

module CustomLogger
  class Log
    @logger ||= Logger.new(STDOUT)

    class << self
      def error_message_400(response)
        @logger.error "#{response[:method].to_s.upcase} \
                        #{response[:url]}: #{response[:status]} \
                        #{error_body(response[:body])}"
      end

      def error_body(body)
        body = XmlHasher.parse(body) if !body.nil? && !body.empty? && body.is_a?(String)
      end

      def error_message_500(response)
        body = 'Something in service is wrong.'
        @logger.error "#{response[:method].to_s.upcase} \
                        #{response[:url]}: \
                        #{["#{response[:status]}:", body].compact.join(' ')}"
      end

      def timeout
        @logger.error 'Timeout produced'
      end

      def request_info(response)
        @logger.info "#{response[:method].to_s.upcase} \
                       #{response[:url]}: #{response[:status]}"
      end

      def info(message)
        @logger.info message.to_s
      end
    end
  end
end
