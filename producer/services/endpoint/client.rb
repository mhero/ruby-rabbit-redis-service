# frozen_string_literal: true

module Endpoint
  class Client
    def initialize
      @connetion = Endpoint::Http.new
    end

    def request_events
      result = @connetion.fetch('api/events')
      result.handle(Event)
    end
  end
end
