module Bass

  def self.depth_first_search(graph, order = graph.nodes, &block)
    search = Algorithm::DepthFirstSearch.new(graph, &block)
    order.each { |node| search.look(node) }
    search
  end

	module Algorithm

		class DepthFirstSearch < GraphSearch

      def execute!
        graph.each_node { |node| look(node) }
      end

      def look(source)
        return nil unless color(source) == :white
        enter(source)
        graph.adjacent(source).each do |edge|
          other = edge.other(source)
          set_parent(other, source) if look(other)
        end
        exit(source)
        self
      end

    end

	end

end