# frozen_string_literal: true

class RabbitQueue
  attr_accessor :conn, :channel, :exchange

  def initialize
    self.conn = Bunny.new(
      host: ENV['RABBIT_SERVER'],
      port: ENV['RABBIT_PORT'],
      vhost: ENV['RABBIT_VHOST'],
      user: ENV['RABBIT_USER'],
      pass: ENV['RABBIT_PASS']
    )
    conn.start
    self.channel = conn.create_channel
    self.exchange = Bunny::Exchange.default(channel)
  end

  def enqueue(data)
    return if data.nil?

    exchange.publish(data, routing_key: ENV['RABBIT_QUEUE'])

    puts 'Event published'
  end
end
