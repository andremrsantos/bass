require 'bass/algorithm/comparator'
require 'bass/algorithm/algorithm'

module Bass

  module Algorithm::Sort

    attr_reader :array

    def initialize(item_or_items, order = :min)
      @comparator = Bass::Comparator.get(order)
      @array = Array(item_or_items)
    end

    private

    def reset; end

    def at(index)
      @array[index]
    end

    def size
      @array.size
    end

    def compare(x, y)
      @comparator.call(x, y)
    end

    def exchange(from, to)
      tmp = @array[from]
      @array[from] = @array[to]
      @array[to] = tmp
    end

  end

end

require 'bass/algorithm/sort/quick_sort'