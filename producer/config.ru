# frozen_string_literal: true

require 'active_support'
require File.expand_path(File.join('config', 'app.rb'))
request_time = ENV['REQUEST_SLEEP_TIME'].to_i || 10

queue = RabbitQueue.new

loop do
  queue.enqueue(Request.call)
  sleep request_time
end
