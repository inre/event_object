require 'bundler/setup'
Bundler.setup

require File.expand_path("./lib/event_object")

RSpec.configure do |config|
  config.color = true
end
