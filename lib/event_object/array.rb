module EventObject
  refine Array do
    # array like event
    def fire(*a, &b)
      collect { |h| h.call(*a, &b) }
    end

    def fire_for(t, *a)
      collect { |h| t.instance_exec(*a, &h) }
    end

    def off(proc=nil)
      (proc) ? delete(proc) : clear
    end
  end
end
