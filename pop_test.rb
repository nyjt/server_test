#!/usr/bin/env ruby

require 'net/pop'

class Pop3Test
  attr_accessor :host, :user, :password, :ssl, :port

  def initialize(host, user, password)
    @host = host
    @user = user
    @password = password
    @ssl = true
    @port = 995
  end

  def test
    puts "Test #{user}@#{host}:#{port}/#{ssl ? 'ssl' : 'nossl'}"
    ssl ? Net::POP3.enable_ssl(OpenSSL::SSL::VERIFY_NONE) : Net::POP3.disable_ssl
    Net::POP3.start(host, port, user, password) do |pop|
      puts "Number of messages on #{host}: #{pop.n_mails}"
      puts 'OK'
      pop.finish
    end
  end
end
