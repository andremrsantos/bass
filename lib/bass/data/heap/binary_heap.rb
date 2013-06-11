module Bass

  class BinaryHeap
    include HeapBase

    def initialize(kind = :min, item_or_items = [])
      super(kind)
      @heap = []
      @keys = {}
      Array(item_or_items).each { |item| push(item) }
    end

    def contains?(key)
      ! @keys[key].nil?
    end

    def push(key, value=key)
      unless contains?(key)
        append_tail(key, value)
        grow
        swim(last)
      end
      self
    end

    def pull
      unless empty?
        exchange(root, last)
        shrink
        sink(root)
        remove_tail
      end
    end

    def peek
      @heap.first
    end

    def change(key, value)
      raise ArgumentError.new('No such key') unless contains?(key)
      @keys[key][:value] = value
      at = @keys[key][:at]
      sink(at) and swim(at)
    end

    def clone
      clone = super
      clone.instance_variable_set(:@heap, @heap.clone)
      clone.instance_variable_set(:@heap, @keys.clone)
      clone
    end

    private

    def root
      0
    end

    def last
      size - 1
    end

    def remove_tail
      tail = @heap.pop
      @keys.delete(tail)
      tail
    end

    def append_tail(key, value)
      @heap << key
      @keys[key] = { value: value, at: last }
    end

    def sink(at)
      while has_son?(at)
        son = younger_son(at)
        if ancestor?(son, at)
          exchange(son, at)
          at = son
        else
          break
        end
      end
    end

    def has_son?(at)
      (2*at + 1) < size
    end

    def younger_son(at)
      a, b = sons(at)
      (b < size && ancestor?(b, a)) ? b : a
    end

    def sons(at)
      left_son = 2 * at + 1
      [left_son, left_son + 1]
    end

    def swim(at)
      while at > 0 && ancestor?(at, father = father(at))
        exchange(at, father)
        at = father
      end
    end

    def father(at)
      (at-1)/2
    end

    def ancestor?(ancestor, descendent)
      super(@keys[@heap[ancestor]][:value], @keys[@heap[descendent]][:value])
    end

    def exchange(from, to)
      tmp = @heap[from]
      @heap[from] = @heap[to]
      @heap[to] = tmp
      @keys[@heap[from]][:at] = from
      @keys[@heap[to]][:at] = to
    end

  end

end