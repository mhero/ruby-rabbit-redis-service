# frozen_string_literal: true

class Request
  include CustomLogger

  def self.call
    Log.info "Request made on: #{Time.now.utc}"

    response = Endpoint::Client.new.request_events

    return if response.is_a? Fault

    EventSerializer.new(
      Endpoint::Client.new.request_events
    ).serialized_json
  end
end
