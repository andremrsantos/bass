require 'bass/data/set'

module Bass

  def self.eccentricity(graph)
    Algorithm::Eccentricity.new(graph).execute
  end

  def self.tree_center(graph)
    Algorithm::EccentricityTree.new(graph).execute
  end

  module Algorithm

    class Eccentricity < GraphAlgorithm
      properties eccentricity: 0

      def execute!
        graph.each_node do |node|
          max = 0
          bfs = Bass::Algorithm::BreadFirstSearch.new(graph) do |n|
            max = bfs.deep(n) if bfs.deep(n) > max
          end
          bfs.look(node)
          set_eccentricity(node, max)
        end
        self
      end

      def center
        min_eccentricity = 1.0/0
        center = []
        graph.each_node do |node|
          if eccentricity(node) == min_eccentricity
            center << node
          elsif eccentricity(node) < min_eccentricity
            min_eccentricity = eccentricity(node)
            center = [node]
          end 
        end
        center
      end

    end

    class EccentricityTree < Eccentricity
      def execute!
        graph = self.graph.clone
        while graph.order > 2
          to_remove = []
          graph.each_node { |n| to_remove << n if graph.degree(n) <= 1 }
          to_remove.each  { |n| graph.remove_node(n) }
        end
        graph.nodes
      end
    end

  end

end