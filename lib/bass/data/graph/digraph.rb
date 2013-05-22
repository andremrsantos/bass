module Bass

  # Directed Graph implementation, where a set of nodes (V) is connected by a
  # set of edges (E), where for each edge (u,v) u, v C V and (u,v) != (v,u)
  class Digraph < Graph
    def initialize(structure = GraphBase::QueueGraph)
      super
      @in_degree = {}
    end

    # @param node [Object] identification node label
    # @return [Integer] the number of exit edges of the node
    def out_degree(node)
      get_node(node).degree
    end

    def in_degree(node)
      @in_degree[node] || 0
    end

    def degree(node)
      out_degree(node) + in_degree(node)
    end

    def transpose
      other = Digraph.new
      each_node {|node| other.add_node(node)}
      each_edge {|edge| other.add_edge(edge.to, edge.from, edge.weight)}
      other
    end

    private

    # (see GraphBase#connect)
    def connect(from, to, weight)
      unless has_edge?(from, to)
        @in_degree[to] ||= 0
        @in_degree[to] += 1
        get_node(from).push_edge new_edge(from, to, weight)
      end
    end

    # (see GraphBase#disconnect)
    def disconnect(from, to)
      if has_edge?(from, to)
        get_node(from).pull_edge new_edge(from, to)
      end
    end

    # (see GraphBase#new_edge)
    # @return [DirectedEdge]
    def new_edge(from, to, weight = 1.0)
      Graph::DirectedEdge.new(from, to, weight)
    end

  end

end