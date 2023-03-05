# frozen_string_literal: true

class RabbitQueue
  attr_accessor :conn

  def initialize
    self.conn = Bunny.new(
      host: ENV['RABBIT_SERVER'],
      port: ENV['RABBIT_PORT'],
      vhost: ENV['RABBIT_VHOST'],
      user: ENV['RABBIT_USER'],
      pass: ENV['RABBIT_PASS']
    )
  end

  def dequeue(store:)
    conn.start
    channel = conn.create_channel

    begin
      queue = channel.queue(ENV['RABBIT_QUEUE'])

      queue.subscribe(manual_ack: true, block: true) do |delivery_info, _metadata, payload|
        puts " [x] Received #{payload}"
        store.save(payload:)
        channel.acknowledge(delivery_info.delivery_tag, false)
      end
    rescue StandardError => e
      puts 'Unexpected error'
      puts e.inspect

      conn.close

      exit(0)
    end
  end
end
