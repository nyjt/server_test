#!/usr/bin/env ruby

require 'net/smtp'

class SmtpTest
  attr_accessor :host, :user, :password, :ssl, :port, :login_mode, :from_domain

  def initialize(host, user, password)
    @host = host
    @user = user
    @password = password
    @ssl = true
    @port = 25
    @login_mode = :login
    @from_domain = host
  end

  def test
    puts "Test #{user}@#{host}:#{port}/#{ssl ? 'ssl' : 'nossl'}"
    smtp = Net::SMTP.new(host, port)
    ssl ? smtp.enable_starttls_auto : smtp.disable_ssl
    smtp.esmtp = true
    smtp.start(from_domain, user, password, login_mode(smtp))
    puts smtp.started? ? 'OK' : 'ERROR'
    smtp.finish
  end

  def login_mode(smtp)
    return :login if smtp.capable_login_auth?
    return :plain if smtp.capable_plain_auth?
    return :cram_md5 if smtp.capable_cram_md5_auth?
  end
end
