module EventObject
  refine Class do
    def def(met, &b)
      define_method met, &b
    end

    def events(*ev)
      ev.each { |name| self.def(name) { var(name, Array) } }
      ev.each { |name| self.def("#{name}!") { |*a| var(name, Array).fire(*a) } }
    end

    def var(name, init=nil)
    	key = "@#{name}"
      class_variable_defined?(key) ? class_variable_get(key) : class_variable_set(key, init.new)
    end
  end
end
