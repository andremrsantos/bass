module Bass

  def self.quicksort(array)
    Algorithm::QuickSort.new(array).execute
  end

  module Algorithm

    class QuickSort < SortAlgorithm

      def execute!(lo = 0, hi = size - 1)
        return @array unless hi <= lo
        less, great = lo, hi
        pivot = at = lo
        while at <= great
          cmp = compare(at, pivot)
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