module Bass

  class Union
    attr_reader :count

    def initialize(unit_or_units)
      @units = {}
      @count = 0
      Array(unit_or_units).each { |unit| add_set(unit) }
    end

    def contains?(unit)
      ! @units[unit].nil?
    end

    def find(unit)
      return nil unless contains?(unit)
      unit = parent(unit) while unit != parent(unit)
      unit
    end

    def add_set(unit)
      unless contains?(unit)
        @units[unit] = { parent: unit, size: 0 } 
        @count += 1
      end
      self
    end

    def connect(a, b)
      if contains?(a) && contains?(b)
        a, b = find(a), find(b)
        return nil if a == b
        @count -= 1
        (size(a) < size(b)) ? append(a, b) : append(b, a)
      end
      self
    end

    def connected?(a,b)
      find(a) == find(b)
    end

    private

    def parent(unit)
      @units[unit] and @units[unit][:parent]
    end

    def size(unit)
      @units[unit] and @units[unit][:size]
    end

    def append(it, to)
      @units[it][:parent] = to
      @units[to][:size] += size(it)
    end

    def to_s
      "<#{self.class}>\n" << @units.map{ |key, value| "#{key} [#{value[:parent]}]" }.join(',')
    end

  end

end