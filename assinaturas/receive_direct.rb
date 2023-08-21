require 'bunny'
require 'json'

connection = Bunny.new
connection.start

channel = connection.create_channel
exchange = channel.direct('direct_logs')

queue = channel.queue('', exclusive: true)

ARGV.each do |severity|
  queue.bind(exchange, routing_key: severity)
end

puts ' [*] Waiting for messages. To exit press CTRL+C'

begin
  queue.subscribe(block: true) do |_delivery_info, _properties, body|
    # puts body
    puts " [x] #{_delivery_info.routing_key}:#{body}"
  end
rescue Interrupt => _e
  channel.close
  connection.close

  exit(0)
end

# ruby receive_direct.rb info warning error os parâmetos são os nomes das rotas
