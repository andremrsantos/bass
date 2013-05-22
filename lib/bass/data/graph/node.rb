# @author André M. Ribeiro-dos-Santos
# @version 0.0.1

require 'forwardable'
require 'bass/data/set'

module Bass::Graph

  # Module with the basic behavior of the Graph Nodes implementations.
  # 
  # @attr_reader [Object] The identification label.
  module Node
    extend Forwardable

    attr_reader :label
    
    # Basic abstract constructor for an Node implementation.
    # 
    # @param label [Object] The identification label.
    # @param attrs [Hash] Node attributes.
    # @return The Node instance.
    # 
    # @abstract
    def initialize(label, attrs = {})
      @label = label
      @attrs  = attrs
    end

    def_delegators :@attrs, :[], :[]=

    # Add an edge
    # 
    # @param edge [Edge] The edge to be added
    # @return [Node] self
    def push_edge(edge)
      raise NotImplementedError, 'Node#push_edge must be implemented'
    end

    # Remove an edge
    # 
    # @param edge [Edge] The edge to be removed
    # @return [Edge] edge
    def pull_edge(edge)
      raise NotImplementedError, 'Node#pull_edge must be implemented'
    end

    # Collection of edges
    # 
    # @return [Array<Edge>] Collection of edges related to the Node.
    def edges
      raise NotImplementedError, 'Node#edges must be implemented'
    end

    # @return [Integer] the number of edges included in this node.
    def degree
      edges.size
    end

    # @return [String] Node string representation.
    def to_s
      string = "Node %5s\n{" % label
      string << @attrs.map { |key, value| '%5s : %5s' }.join(',')
      string << "}\n"
      string << edges.map { |edge| edge.other(label) }.join(' -> ')
    end

    # @return [String] Node inspection.
    def inspect
      '<%s : %s>' % [self.class, label]
    end
  
    # Node implementation for edge list graph implementation. Uses an Bass::Set
    # to represent the collection of edges related to the Node.
    # 
    # @see Bass::Set
    class QueueNode
      include Node

      def initialize(label, attrs = {})
        super
        @edges = Bass::Set.new
      end

      # (see Node#push_edge)
      def push_edge(edge)
        @edges.push edge
        self
      end

      # (see Node#pull_edge)
      def pull_edge(edge)
        @edges.pull edge
      end

      # (see Node#edges)
      def edges
        @edges.to_a
      end 

    end

    # Node implementation for adjacency matrix graph implementation. It defines
    # their label, based on a instance counter.
    class AdjacencyNode
      include Node
      @@counter = -1

      # @param attrs [Hash] Node attributes.
      # @return The Node instance.
      def initialize(attrs = {})
        super(@@counter += 1, attrs)
        @edges = Array.new(@@counter)
      end

      # (see Node#push_edge)
      def push_edge(edge)
        raise ArgumentError, 'Need an edge' unless edge.kind_of?(Edge)
        @edges[edge.other(label)] = edge unless @edges[edge.other(label)]
        self
      end

      # (see Node#pull_edge)
      def pull_edge(edge)
        raise ArgumentError, 'Need an edge' unless edge.kind_of?(Edge)
        @edges[edge.other(label)] = nil
      end

      # (see Node#edges)
      def edges
        @edges.select { |edge| edge.kind_of? Edge }
      end

    end

  end
end