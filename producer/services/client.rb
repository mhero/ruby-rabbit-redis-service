# frozen_string_literal: true

class Client
  def initialize
    @connetion = Endpoint::Http.new
  end

  def request_events
    binding.pry
    result = @connetion.fetch('api/events')
    result.handle(Event)
  end
end

