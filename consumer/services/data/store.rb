# frozen_string_literal: true

class Store
  attr_accessor :redis_client

  EVENT_ONLINE_BY_START_DATE = 'events:online:by-start-date'
  EVENT_ONLINE_BY_END_DATE = 'events:online:by-end-date'

  def initialize(client:)
    @redis_client = client
  end

  def save(payload:)
    data = JSON.parse(payload, symbolize_names: true)
    data[:data].each do |event|
      event_key = "event:#{event[:id]}"

      upsert(event, event_key)

      start_datetime_score = DateTime.parse(event[:attributes][:start_at]).to_i
      redis_client.zadd(EVENT_ONLINE_BY_START_DATE, start_datetime_score, event_key)

      end_datetime_score = DateTime.parse(event[:attributes][:end_at]).to_i
      redis_client.zadd(EVENT_ONLINE_BY_END_DATE, end_datetime_score, event_key)
    end
  rescue Redis::BaseError => e
    puts "Error storing data: #{e.inspect}"
    puts payload
  end

  private

  def upsert(event, event_key)
    attributes = event[:attributes]
    if @redis_client.get(event_key).nil?
      @redis_client.set(event_key, attributes.to_json)
    else
      current = JSON.parse(@redis_client.get(event_key))
      @redis_client.set(event_key, merge(current, attributes).to_json)
    end
  end

  def merge(current, updated)
    current.symbolize_keys.merge(updated.symbolize_keys)
  end
end
