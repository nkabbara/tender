require "rubygems"
require "spec"
require "nokogiri"
require 'fakeweb'
require File.join(File.dirname(__FILE__), '..', 'lib', 'tender')

FakeWeb.allow_net_connect = false

def register_uri(options = {})
  defaults = {
    :code => 200,
    :body => "Some message",
    :uri  => "http://discussion/queue/123"
  }.merge(options)

  FakeWeb.register_uri(
    :post,
    defaults[:uri],
    :body => defaults[:body],
    :status => [defaults[:code], "created!"]
  )
  puts "regsistered"
end
