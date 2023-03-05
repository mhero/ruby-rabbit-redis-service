# frozen_string_literal: true

class Search
  EVENT_ONLINE_BY_START_DATE = 'events:online:by-start-date'
  EVENT_ONLINE_BY_END_DATE = 'events:online:by-end-date'

  def initialize(redis_client, start_at, end_at, offset:, limit:)
    @redis_client = redis_client
    @start_at_i = DateTime.parse(start_at).to_i
    @end_at_i = DateTime.parse(end_at).to_i
    @offset = offset
    @limit = limit
  end

  def call
    from_key = "search:from:#{start_at_i}"
    until_key = "search:until:#{end_at_i}"

    online_events_from(start_date_target: start_at_i, store_in: from_key)
    online_events_until(end_date_target: end_at_i, store_in: until_key)

    search(set_from: from_key, set_until: until_key, limit:, offset:)
  end

  private

  attr_accessor :start_at_i, :end_at_i, :limit, :offset, :redis_client

  def search(set_from:, set_until:, limit: '+inf', offset: '0')
    search_result_key = 'search'
    redis_client.zinterstore(search_result_key, [set_from, set_until])

    keys = redis_client.zrange(search_result_key, 0, -1)
    redis_client.mget(keys)
  end

  def online_events_from(start_date_target:, store_in:)
    redis_client.zrangestore(
      store_in,
      EVENT_ONLINE_BY_START_DATE,
      start_date_target,
      '+inf',
      by_score: true
    )
  end

  def online_events_until(end_date_target:, store_in:)
    redis_client.zrangestore(
      store_in,
      EVENT_ONLINE_BY_END_DATE,
      '-inf',
      end_date_target,
      by_score: true
    )
  end
end
