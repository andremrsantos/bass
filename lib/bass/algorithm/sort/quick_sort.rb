require 'bass/algorithm/comparator'

module Bass

  def self.quicksort(array)
    Algorithm::Sort::QuickSort.new(array).execute
  end

  module Algorithm::Sort

    class QuickSort
      include Bass::Algorithm::Sort

      def execute!(lo = 0, hi = size - 1)
        return @array unless hi <= lo
        less, great = lo, hi
        pivot = at = lo
        while at <= great
          cmp = self.at(at) <=> self.at(pivot)
          if cmp < 0
            exchange(less, at)
            less += 1
            at += 1
          elsif cmp > 0
            exchange(at, great)
            great -= 1
          else
            at +=1
          end
        end
        execute!(lo, less-1)
        execute!(great+1, hi)
        @array
      end

    end

  end

end