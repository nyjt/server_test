#!/usr/bin/env ruby

require 'net/imap'

class ImapTest
  attr_accessor :host, :user, :password, :port, :ssl, :debug

  def initialize(host, user, password)
    @host = host
    @user = user
    @password = password
    @port = 993
    @ssl = true
    @debug = false
  end

  def test
    puts "Test #{host}:#{port}"
    imap = Net::IMAP.new(host, port, ssl, nil, false)
    result = imap.login(user, password)
    puts debug ? result.inspect : "Login: #{result.name}"
    result = imap.select('INBOX')
    puts debug ? result.inspect : "INBOX: #{result.name}"
    imap.logout
    imap.disconnect
  end
end
