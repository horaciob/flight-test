# frozen_string_literal: true

require 'bundler'
Bundler.require(:default, :test)
require 'simplecov'
SimpleCov.start
require_all 'app/models/**.rb'

