# frozen_string_literal: true

require 'active_support'
require File.expand_path(File.join('config', 'app.rb'))

redis_client = Redis.new(
  host: ENV['REDIS_HOST'],
  port: ENV['REDIS_PORT']
)
redis_store = Store.new(client: redis_client)
queue = RabbitQueue.new
queue.dequeue(store: redis_store)
