require 'bass/comparator'
require 'bass/algorithm'

module Bass::Algorithm

  class SortAlgorithm < Base
    
    attr_reader :array, :order

    def initialize(item_or_items, order = :asc)
      @order = (order == :desc)? -1 : 1
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
      order * Comparator.compare(@array[x], @array[y])
    end

    def exchange(from, to)
      tmp = @array[from]
      @array[from] = @array[to]
      @array[to] = tmp
    end

  end

end

require 'bass/algorithm/sort/quick_sort'