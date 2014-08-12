require "spec_helper"
describe EventObject do
  using EventObject

  it "should create array of events" do
    events = []
    proc   = lambda { :result }
    events.push proc
    events_with_arguments = []
    events_with_arguments.push lambda { |num| num+1 }

    expect(events.fire.last).to be(:result)
    expect(events.fire_for(self).last).to be(:result)
    expect(events_with_arguments.fire(5).last).to be(6)

    events.off(proc)
    expect(events).to be_empty
  end

  it "should NilClass has fire" do
    expect(nil.fire).to eq([])
    expect(nil.fire_for(self)).to eq([])
  end

  it "should create events and fire them" do
    class EventEmitter
      events :success, :error
    end

    emitter = EventEmitter.new
    emitter.on :success do
      18
    end
    emitter.on :success do
      42
    end

    expect(emitter.success!).to eq([18,42])
    expect(emitter.success.fire).to eq([18,42])
    expect(emitter.error).to be_empty
    expect(emitter.error.fire).to be_empty
  end
end
