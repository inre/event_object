module Event
  refine Class
    def def(method, &b)
      define_method method, &b
    end

    def events(*names)
      names.each { |name| self.def(name) { var(name, Array) } }
      names.each { |name| self.def("#{name}!") { |*a| var(name, Array).fire(*a) } }
    end

    def var(name, init=nil)
    	key = "@#{name}"
      class_variable_defined?(key) ? class_variable_get(key) : class_variable_set(key, init.new)
    end
  end
end
