require "spec_helper"

describe EventObject do
  using EventObject

  class EventEmitter
    events :success, :error, :data
  end

  class ParentObject
    def ok
      'OK'
    end
  end

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

  # dup required in fires
  it "add event in event" do
    emitter = EventEmitter.new
    counter = 0
    emitter.on :success do
      counter += 1
      emitter.on :success do
        counter += 1
      end
    end

    emitter.success!

    expect(counter).to be 1
  end

  it "listen other object" do
    emitter = EventEmitter.new
    obj = ParentObject.new
    obj.listen(emitter, :success, :ok)
    expect(emitter.success!.last).to eq 'OK'

    emitter.off(:success, obj, :ok)
    expect(emitter.success!).to be_empty
  end

  it "stop listen" do
    emitter = EventEmitter.new
    obj = ParentObject.new
    obj.listen(emitter, :success, :ok)
    expect(emitter.success!.last).to eq 'OK'

    obj.stop_listen(emitter, :success)
    expect(emitter.success!).to be_empty
  end

  it "events chain" do
    emitter = EventEmitter.new
    emitter.on :data do |chunk|
      chunk + " world"
    end
    emitter.on :data do |chunk|
      chunk + "!!!"
    end

    data =  emitter.data.chain('Hello')

    expect(data).to eq('Hello world!!!')
  end

  it "define singleton method" do
    expect {
      object = Object.new
      object.def :foo do
        1
      end
      expect(object.foo).to be 1
    }.to_not raise_error
  end
end
