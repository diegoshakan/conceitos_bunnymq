require 'bunny'
require 'json'

product = { name: "Xbox", unity: "UN" }.to_json

connection = Bunny.new
connection.start

channel = connection.create_channel

exchange = channel.fanout('logs')
# exchange = channel.direct('logs') verify tutorial 4
exchange.publish(product)

puts " [x] Sent 'Hello World!'"

connection.close
