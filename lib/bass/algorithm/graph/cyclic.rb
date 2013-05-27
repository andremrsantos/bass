require 'bass/data/set'

module Bass

  def self.has_cycle?(graph)
    Algorithm::CyclicDetector.new(graph).execute
  end

  module Algorithm

    class CyclicDetector < DepthFirstSearch

      def execute!
        super
        @cyclic
      end

      def look(node)
        unless cyclic?
          @cyclic = true if cycle?(node)
          super
        end
        @cyclic
      end

      def cyclic?
        @cyclic
      end

      def reset
        super
        @cyclic = false
        @last_visit = nil
      end

      private

      def cycle?(u)
        color(u) == :grey && case graph
                             when Graph then enter_time(@last_visit) - time > 3
                             else true
                             end
      end

      def enter(node)
        super
        @last_visit = node
      end

      def exit(node)
        super
        @last_visit = parent(node)
      end
    end

  end

end