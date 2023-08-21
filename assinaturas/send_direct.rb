require 'bunny'
require 'json'

product = { name: "Xbox", unity: "UN" }.to_json

connection = Bunny.new
connection.start

channel = connection.create_channel

exchange = channel.direct('direct_logs')

severity = ARGV.shift || 'info'
message = ARGV.empty? ? 'Hello World!' : ARGV.join(' ')

exchange.publish(message, routing_key: severity)

puts " [x] Sent 'Hello World!'"

connection.close

# ruby send_direct.rb error "Run. Run. Or it will explode." os parâmetros são a rota para qual a mensagem será enviada
# e a mensagem a qual será enviada.
