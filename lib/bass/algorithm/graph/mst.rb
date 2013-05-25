require 'bass/data/heap'
require 'bass/data/union'
require 'bass/algorithm/sort_algorithm'

module Bass

  def self.minimal_spanning_tree(graph, strategy = :primm)
    mst = case strategy
          when :kruskal then Algorithm::KruskalMST.new(graph)
          else Algorithm::PrimmMST.new(graph)
          end
    mst.execute
  end

  module Algorithm

    class MST < GraphAlgorithm
      attr_reader :tree

      protected

      def add_edge(edge)
        u, v = edge.nodes
        tree.add_edge(u, v, edge.weight)
      end

      private

      def reset
        super
        @tree = Bass::Graph.new
        graph.each_node {|node| tree.add_node(node)}
      end

    end

    class PrimmMST < MST
      default_attr on_tree: false

      def execute!
        start = graph.nodes.first
        set_on_tree(start, true)
        @heap = BinaryHeap.new(graph.adjacent(start))
        add_edge(edge) while tree.size < graph.order-1 && ! @heap.empty?
        tree
      end

      private

      def valid?(edge)
        u, v = edge.nodes
        ( on_tree(u) && !on_tree(v) ) || ( on_tree(v) && !on_tree(u) )
      end

      def add_edge(edge)
        if valid?(edge)
          super(edge)
          other = next_node(edge)
          set_on_tree(other, true)
          graph.adjacent(other).each { |edge| @heap.push edge }
        end
      end

      def next_node(edge)
        other = edge.either
        other = on_tree(other) ? edge.other(other) : other 
      end

    end

    class KruskalMST < MST

      def execute!
        @union = Bass::Union.new(graph.nodes)
        edges = Bass.quicksort(graph.edges)
        add_edge(edge)  while @union.count > 1 && !edges.empty?
        tree
      end

      private

      def valid?(edge)
        u, v = edge.nodes
        ! @union.connected?(u, v)
      end

      def add_edge(edge)
        if valid?(edge)
          super(edge)
          @union.connect(edge.nodes)
        end
      end

    end

  end

end