# frozen_string_literal: true

require 'json'
require 'faraday'
require 'faraday_middleware'

module Endpoint
  class Http
    include CustomLogger

    DEFAULT_TIMEOUT = 3 # seconds

    def initialize
      @connection = Faraday.new(
        url: ENV['ENDPOINT'],
        headers: { 'Content-Type' => 'application/xml' },
        request: { timeout: DEFAULT_TIMEOUT }
      ) do |conn|
        conn.use Endpoint::ServerErrors
        conn.adapter Faraday.default_adapter
      end
    end

    def fetch(endpoint)
      begin
        response = @connection.get(endpoint)
      rescue Faraday::TimeoutError
        Log.timeout
      end
      ResponseHandler.new(response)
    end
  end
end
