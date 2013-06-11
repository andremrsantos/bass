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
      properties on_tree: false, edge_to: nil

      def execute!
        look(graph.nodes.first)
      end

      def look(root)
        @heap = Bass::BinaryHeap.new()
        set_on_tree(root, true)
        scan(root)
        scan(@heap.pull) until @heap.empty?
        tree
      end

      private

      def valid?(edge)
        u, v = edge.nodes
        ( on_tree(u) && !on_tree(v) ) || ( on_tree(v) && !on_tree(u) )
      end

      def add_edge(node)
        return nil if edge_to(node).nil?
        super(edge_to(node))
      end

      def scan(node)
        set_on_tree(node, true)
        add_edge(node)
        graph.adjacent(node).each do |edge|
          other = edge.other(node)
          next if on_tree(other)
          if edge_to(other).nil? || edge < edge_to(other)
            set_edge_to(other, edge)
            @heap.contains?(other) ? @heap.change(other, edge) : @heap.push(other, edge)
          end
        end
      end

    end

    class KruskalMST < MST

      def execute!
        @union = Bass::Union.new(graph.nodes)
        edges = Bass.quicksort(graph.edges)
        add_edge(edges.shift) while @union.count > 1 && !edges.empty?
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
          @union.connect(*edge.nodes)
        end
      end

    end

  end

end