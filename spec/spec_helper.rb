# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'
require 'bundler'
Bundler.require(:default)
Bundler.require(Sinatra::Base.environment)
require 'simplecov'
SimpleCov.start
require_all 'app/models/**.rb'

require File.expand_path '../server.rb', __dir__

module RSpecMixin
  include Rack::Test::Methods
  def app
    described_class
  end
end

RSpec.configure { |c| c.include RSpecMixin }
