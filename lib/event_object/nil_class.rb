module EventObject
  refine NilClass do
    def fire(*a)
      []
    end

    def fire_for(t, *a)
      []
    end
  end
end
