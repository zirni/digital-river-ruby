# require 'webmock/rspec'
require "digital_river"
require "simplecov"

SimpleCov.start

Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}
