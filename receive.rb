#!/usr/bin/env ruby
require 'bunny'
require 'json'

# class Stock
#   attr_reader :product

#   def initialize(product)
#     @product = product
#   end

#   def create_stock
#     "Recebemos #{product['name']} sua unidade é #{product['unity']}"
#   end
# end

FUND_FILES_TO_VALIDATE_QUEUE = 'fund-files-to-validate'.freeze

connection = Bunny.new(
  host: "ec2-18-212-82-38.compute-1.amazonaws.com",
  port: 5672,
  user: "novo-fidc",
  password: "rgvrgbtrgb35",
  vhost: "novo-fidc"
)
connection.start

channel = connection.create_channel
queue = channel.queue(FUND_FILES_TO_VALIDATE_QUEUE, durable: true)



begin
  puts ' [*] Waiting for messages. To exit press CTRL+C'
  # block: true is only used to keep the main thread
  # alive. Please avoid using it in real world applications.
  queue.subscribe(block: true) do |_delivery_info, _properties, body|
    # @body = JSON.parse(body)
    # item = Stock.new(@body).create_stock

    puts body
  end
rescue Interrupt => _
  connection.close

  exit(0)
end





