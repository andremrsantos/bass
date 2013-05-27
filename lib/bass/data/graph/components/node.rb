# @author André M. Ribeiro-dos-Santos
# @version 0.0.1

require 'forwardable'
require 'bass/data/set'

module Bass::GraphBase

  # Module with the basic behavior of the Graph Nodes implementations.
  #
  # @attr_reader [Object] The identification label.
  module Node
    extend Forwardable

    attr_reader :label, :attrs

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

    # @param [Edge] edge ti be queried
    # @return [true, false] if collection of edges include *edge*
    def has_edge?(edge)
      edges.include?(edge)
    end

    # @return [Integer] the number of edges included in this node.
    def degree
      edges.size
    end

    # @return [String] Node string representation.
    def to_s
      string = "Node %5s  {" % label
      string << @attrs.map { |key, value| '%5s : %5s' }.join(',')
      string << "} | edges: "
      edges_list = edges.map do |edge| 
                '%s : %2.2f' % [edge.other(label), edge.weight]
              end
      string << edges_list.join(' -> ')
    end

    # @return [String] Node inspection.
    def inspect
      '<%s : %s>' % [self.class, label]
    end

    def clone
      clone = super
      attrs = {}
      @attrs.each { |k,v| attrs[k] = v.clone if v.nil? }
      clone.instance_variable_set(:@attrs, attrs)
      edges = self.instance_variable_get(:@edges).clone
      clone.instance_variable_set(:@edges, edges )
      clone
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

      # (see Node#has_edge?)
      def has_edge?(edge)
        @edges.include? edge
      end

    end

    # Node implementation for adjacency matrix graph implementation. It defines
    # their label, based on a instance counter.
    class AdjacencyNode
      include Node
      @@counter = -1
      @@index_label = []
      @@label_index = {}

      # @param attrs [Hash] Node attributes.
      # @return The Node instance.
      def initialize(label, attrs = {})
        super
        @@index_label[@@counter += 1] = label
        @@label_index[label] = @@counter
        @edges = Array.new(@@counter)
      end

      # (see Node#push_edge)
      def push_edge(edge)
        raise ArgumentError, 'Need an edge' unless edge.kind_of?(Edge)
        other = to_index edge.other(label)
        @edges[other] = edge unless @edges[other]
        self
      end

      # (see Node#pull_edge)
      def pull_edge(edge)
        raise ArgumentError, 'Need an edge' unless edge.kind_of?(Edge)
        @edges[to_index edge.other(label)] = nil
      end

      # (see Node#edges)
      def edges
        @edges.select { |edge| edge.kind_of? Edge }
      end

      # (see Node#has_edge?)
      def has_edge?(edge)
        raise ArgumentError, 'Need an edge' unless edge.kind_of?(Edge)
        ! @edges[edge.other(label)].nil?
      end

      private

      # @param label [Integer] Node identification label
      # @return [Integer] the position of an node in the matrix
      def to_index(label)
        @@label_index[label]
      end

      # @param index [Integer] position of in the Array
      # @return [Object] the label of the node at index
      def to_label(index)
        @@index_label[index]
      end
    end

  end
end