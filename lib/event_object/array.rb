module EventObject
  refine Array do
    # array like event
    def fire(*a, &b)
      dup.collect { |h| h.call(*a, &b) }
    end

    # run events consecutive
    def chain(a)
      dup.inject(a) { |a, c| c.call(a) }
    end

    def fire_for(t, *a)
      dup.collect { |h| t.instance_exec(*a, &h) }
    end

    def off(proc=nil)
      (proc) ? delete(proc) : clear
    end
  end
end
