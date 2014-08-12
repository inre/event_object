module EventObject
  class Array
    # array like event
    def fire(*a, &b)
      each { |h| h.call(*a, &b) }
    end

    def fire_for(t, *a)
      each { |h| t.instance_exec(*a, &h) }
    end

    def off(proc=nil)
      (proc) ? delete(proc) : clear
    end
  end
end
