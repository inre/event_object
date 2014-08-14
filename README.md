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

## Contributing

1. Fork it ( https://github.com/chelovekov/event-object/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
