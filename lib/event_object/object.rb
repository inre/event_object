module EventObject
  refine Object do
    def def(method, &b)
      define_singleton_method method, &b
    end

    def var(name, init=nil)
      instance_variable_get("@#{name}") || instance_variable_set("@#{name}", (init.is_a?(Class) ? init.new : init))
    end

    def on(name, bb=nil, &b)
      var(name, Array).tap { |e| e << (bb || b) }; (bb || b)
    end

    #
    # obj.off(:ev)
    # obj.off(:ev, proc)
    # obj.off(:ev, target, :meth)
    def off(*a)
      case a.size
      when 1 then var(a[0], Array).clear
      when 2 then var(a[0], Array).tap { |e| e.delete a[1] }
      when 3 then var(a[0], Array).tap { |e| e.delete a[1].method(a[2]) }
      end
      self
    end

    def once(name, &b)
      (ev = nil).tap { |ev|
        var(name, Array).tap { |e| e << (ev = ->() { b.call; e.delete(ev) }) }
      }
    end

    def listen(target, ev, meth)
      target.on ev, method(meth)
    end

    def stop_listen(target, ev)
      target.var(ev, Array).delete_if { |e| e.is_a?(Method) && e.receiver == self }
    end
  end
end
