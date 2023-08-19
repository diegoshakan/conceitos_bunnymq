require 'bunny'
require 'json'

connection = Bunny.new
connection.start

channel = connection.create_channel
exchange = channel.fanout('logs')

queue = channel.queue('', exclusive: true)
queue.bind(exchange)

puts ' [*] Waiting for messages. To exit press CTRL+C'

begin
  queue.subscribe(block: true) do |_delivery_info, _properties, body|
    puts body
  end
rescue Interrupt => _e
  channel.close
  connection.close
end
