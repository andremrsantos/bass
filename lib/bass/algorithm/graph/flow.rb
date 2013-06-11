module Bass

end

module Bass::Algorithm

  class MaxFlow < GraphAlgorithm
    attr_reader :residues

    def reset
      super
      @residues = graph.clone
      @system_flow = 0
      @flow = {}
      graph.each_edge { |e| @flow[e] = 0 }
    end

    def execute!
      while path = find_path
        p path
        cf = min_room(path)

        each_path_edge(path) do |from, to|
          edge = graph.get_edge(from, to)
          if edge
            @flow[edge] += cf
            residues.remove_edge(to, from)
            residues.add_edge(to, from, @flow[edge])
          else
            other = graph.get_edge(to, from)
            @flow[other] -= cf
            residues.remove_edge(from, to)
            residues.add_edge(from, to, @flow[other])
          end
        end
        @system_flow += cf
      end
      @system_flow
    end

    def to_s
      str = "<#{self.class}>\n---Network flow: %f\n---Flow:---\n" % @system_flow
      str << @flow.map { |key, value| "%6s -> %6s : %f / %f" % [*key.nodes, key.weight, value] }.join("\n")
    end

    private

    def find_path
      nodes = { source: { parent: nil, level: 0 } }

      stack = [:source]
      until stack.empty? || !nodes[:exit].nil?
        node = stack.pop
        residues.adjacent(node).each do |edge|
          next unless nodes[edge.to].nil? && room(node, edge.to) > 0
          nodes[edge.to] = { parent: node, level: nodes[node][:level] + 1 }
          stack << edge.to
        end
      end
      build_path(nodes) unless nodes[:exit].nil?
    end

    def build_path(nodes)
      path = []
      pointer = :exit
      until pointer.nil?
        path.unshift pointer
        pointer = nodes[pointer][:parent]
      end
      path
    end

    def each_path_edge(path, &block)
      (1...path.size).each { |i| block.call(path[i-1], path[i]) }
    end

    def min_room(path)
      min = 1.0/0
      each_path_edge(path) do |from, to|
        if (r = room(from, to)) < min
          min = r
        end
      end
      min
    end

    def room(from, to)
      edge = residues.get_edge(from,to)
      @flow[edge].nil? ? edge.weight : edge.weight - @flow[edge]
    end

    def return_edge?(from,  to)
      ! graph.has_edge?(from, to)
    end

  end

end