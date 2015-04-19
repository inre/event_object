module EventObject
  refine Object do
    def def(method, &b)
      define_method method, &b
    end

    def var(name, init=nil)
      instance_variable_get("@#{name}") || instance_variable_set("@#{name}", (init.is_a?(Class) ? init.new : init))
    end

    def on(name, &b)
      var(name, Array).tap { |e| e << b }; b
    end

    #
    # obj.off(:data)
    # obj.off(:data, proc)
    # obj.off(target, :data, proc) => target.off(:data, proc)
    def off(*a)
      case a.size
      when 1 then var(a[0], Array).clear
      when 2 then var(a[0], Array).tap { |e| e.delete a[1] }
      when 3 then a[0].off(a[1], a[2])
      end
      self
    end

    def once(name, &b)
      (ev = nil).tap { |ev|
        var(name, Array).tap { |e| e << (ev = ->() { b.call; e.delete(ev) }) }
      }
    end

    def listen(object, name, meth)
      object.on :name, &method(meth)
    end
  end
end
