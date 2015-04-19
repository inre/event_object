# EventObject

EventObject - event-driven programming for ruby

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'event_object'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install event_object

## Usage

```ruby
using EventObject
class EventEmitter
  events :success, :error
end

emitter = EventEmitter.new
emitter.on :success do
  [200, {}, "OK"]
end
p emitter.success!
```
