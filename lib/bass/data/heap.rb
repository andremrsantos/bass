require 'bass/comparator'

module Bass

  module HeapBase
    include Enumerable

    attr_reader :size

    def initialize(kind = :min)
      @comparator = Bass::Comparator.get(kind)
      @size = 0
    end

    def empty?
      size == 0
    end

    def each(&block)
      clone = self.clone
      yield(clone.pull) until clone.empty?
    end

    def to_s
      inspect
    end

    def inspect
      "<#{self.class}>"
    end

    private

    def grow
      @size += 1
    end

    def shrink
      @size -= 1
    end

    def ancestor?(a, b)
      @comparator.call(a, b)
    end

  end

end

require 'bass/data/heap/binary_heap'