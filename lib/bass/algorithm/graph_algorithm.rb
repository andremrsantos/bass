require 'bass/algorithm'
require 'bass/data/graph'

module Bass::Algorithm

  class GraphAlgorithm < Base

    attr_reader :graph

    def initialize(graph)
      unless graph.kind_of? Bass::GraphBase
        raise ArgumentError.new('Works only on graphs')
      end
      @graph = graph
      super()
    end

    private

    def reset
      super graph.nodes
    end

  end

end

require 'bass/algorithm/graph/mst'