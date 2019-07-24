# frozen_string_literal: true

require 'async'
require 'async/http/endpoint'
require 'async/websocket/client'

module Client
  URL = 'https://localhost:9292'
  ENDPOINT = Async::HTTP::Endpoint.parse URL
  MESSAGE = ARGV.first || 'ping'

  module_function

  def call
    Async do
      Async::WebSocket::Client.connect ENDPOINT do |connection|
        puts "Sending message: #{MESSAGE}"
        connection.write MESSAGE
        connection.flush

        message = connection.read
        puts "Receiving message: #{message}"
      end
    end
  end
end

Client.call
