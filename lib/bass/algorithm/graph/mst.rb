require 'bass/data/heap'
require 'bass/data/union'
require 'bass/algorithm/sort_algorithm'

module Bass

  def self.minimal_spanning_tree(graph, strategy = :primm)
    mst = case strategy
          when :kruskal then Algorithm::Graph::KruskalMST.new(graph)
          else Algorithm::Graph::PrimmMST.new(graph)
          end
    mst.execute
  end

  module Algorithm::Graph

    class MST
      include Bass::Algorithm::Graph
      attr_reader :mst

      private

      def reset
        super
        @mst = graph.class.new
      end

    end

    class PrimmMST < MST
      default_attr on_tree: false

      def execute!
        start = graph.nodes.first
        set_on_tree(start, true)
        edge_heap = BinaryHeap.new(graph.adjacent(start))
        while mst.order < graph.order && ! edge_heap.empty?
          if valid?(edge = edge_heap.pull)
            u, v = edge.nodes
            mst.add_edge(u, v, edge.weight)
          end
        end
        mst
      end

      private

      def valid?(edge)
        u, v = edge.nodes
        ( on_tree(u) && !on_tree(v) ) || ( on_tree(v) && !on_tree(u) )
      end

    end

    class KruskalMST

      def execute!
        edges = Bass.quicksort(graph.edges)
        while @union.count < graph.size
      end

      private

      def reset
        @union = Bass::Union.new(graph.nodes)
      end

      def valid?(edge)
        u, v = edge.nodes
      end

    end

  end

end