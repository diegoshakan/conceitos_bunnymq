#!/usr/bin/env ruby
require 'bunny'
# require 'json'

# class Stock
#   attr_reader :product

#   def initialize(product)
#     @product = product
#   end

#   def create_stock
#     "Recebemos #{product['name']} sua unidade é #{product['unity']}"
#   end
# end

connection = Bunny.new(automatically_recover: false)
connection.start

channel = connection.create_channel
queue = channel.queue('hello')



begin
  puts ' [*] Waiting for messages. To exit press CTRL+C'
  # block: true is only used to keep the main thread
  # alive. Please avoid using it in real world applications.
  queue.subscribe(block: true) do |_delivery_info, _properties, body|
    # @body = JSON.parse(body)
    # item = Stock.new(@body).create_stock

    # puts item
  end
rescue Interrupt => _
  connection.close

  exit(0)
end





