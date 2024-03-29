# class Publisher
#   # in order to publish message we need a exchange name
#   # Note that RabbitMQ does not care about the payload
#   # we will be using JSON-encoded strings
#   def self.publish(exchange, message = {})
#     # grab the fanout exchange
#     x = channel.fanout("product.#{exchange}")
#     # and simply publish message
#     x.publish(message.to_json)
#   end

#   def self.channel
#     @channel ||= connection.create_channel
#   end

#   # we are using default settings here
#   # the Bunny.new() is a place to put any
#   # specific RabbitMQ settings like host or port
#   def self.connection
#     @connection ||= Bunny.new.tap do |c|
#       c.start
#     end
#   end
#   # now we need to call Publisher.publish() every time a new Product is created.

# end

require 'bunny'
require 'json'

# connection = Bunny.new(automatically_recover: false)
connection = Bunny.new(
  host: "ec2-18-212-82-38.compute-1.amazonaws.com",
  port: 5672,
  user: "novo-fidc",
  password: "rgvrgbtrgb35",
  vhost: "novo-fidc"
)
connection.start

channel = connection.create_channel
product = { name: "Xbox", unity: "UN" }
message = {
  "number": "002",
  "name": "Banco Teste S.A.",
  "description": "Banco Teste S.A.",
  "active": true
}
queue = channel.queue('remittance-manager-info', durable: true)

channel.default_exchange.publish(product.to_json, routing_key: queue.name)
puts " [x] Sent 'Hello World!'"

connection.close
