$LOAD_PATH.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require "active_support"
require "httparty"
require "hashie"
require 'addressable/template'

module Tender
  class TenderError < ::RuntimeError; end

  mattr_accessor :auth_token
  def self.configure
    yield self if block_given?
  end
end

require "tender/discussion"
require "tender/queue"
