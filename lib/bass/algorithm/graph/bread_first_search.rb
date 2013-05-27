module Bass

  def self.bread_first_search(graph, order = graph.nodes, &block)
    search = Algorithm::BreadFirstSearch.new(graph, &block)
    order.each { |node| search.look(node) }
    search
  end

  module Algorithm

    class BreadFirstSearch < GraphSearch
      properties deep: 0

      def execute!
        graph.each_node { |node| look(node) }
        self
      end

      def look(source)
        return nil unless color(source) == :white
        queue = [source]
        while node = queue.shift
          enter(node)
          exit(node)
          graph.adjacent(node).each do |edge|
            other = edge.other(node)
            queue << other if expand_path_to(node, other)
          end
        end
        self
      end

      private

      def expand_path_to(from, to)
        if color(to) == :white
          set_parent(to, from)
          set_color(to, :grey)
          set_deep(to, deep(from) + 1)
        end
      end

    end

  end

end