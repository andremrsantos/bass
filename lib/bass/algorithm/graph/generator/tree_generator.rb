module Bass

  def self.tree_generator(order = 10, cc = 3, &block)
    Algorithm::TreeGenerator.new(order, cc, &block).execute
  end

	module Algorithm

    class TreeGenerator < Base

      def initialize(order, cc, &block)
        @order = order
        @cc = cc
        @block = block ? block : ->(*_){ 1 }
      end

      def execute!
        graph = Bass::Graph.new
        (1..@order).each { |node| graph.add_node(node) }

        graph.each_node do |node|
          break unless has_son?(node)
          sons(node).each do |son| 
            graph.add_edge(node, son, @block.call(node, son) )
          end
        end
        graph
      end

      private

      def reset;end

      def sons(father)
        sons = []
        pivot = father * @cc
        (1..@cc).each do |fc| 
          nxt = (pivot + 2 - fc)
          sons << nxt if nxt <= @order
        end
        sons
      end

      def has_son?(node)
        (node * @cc) - @cc + 2 <= @order
      end

    end

  end

end