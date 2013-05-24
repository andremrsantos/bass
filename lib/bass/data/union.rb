module Bass

  class Union

    attr_reader :count

    def initialize(unit_or_units)
      @units = {}
      Array(unit_or_units).each { |unit| push(unit) }
      @count = @units.size
    end

    def contains?(unit)
      ! @units[unit].nil?

    def find(unit)
      return nil unless contains?(unit)
      unit = parent while unit != parent = parent(unit)
      unit
    end

    def push(unit)
      unless contains?(unit)
        @units[unit] = { parent: unit, size: 0}
      end
      self
    end

    def connect(a, b)
      unless contains?(a) && contains?(b)
        raise ArgumentError.new('Unknown units')
      end
      root_a, root_b = find(a), find(b)
      if size(root_a) < size(root_b)
        append(root_a, root_b)
      elsif size(root_b) < size(root_a)
        append(root_b, root_a)
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
      @units[unit] and @units[unit][:parent]
    end

    def append(it, to)
      @units[it][:parent] = to
      @units[to][:size] += size(it)
    end

  end

end