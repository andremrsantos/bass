require 'bass/algorithm/algorithm'
require 'bass/data/graph'

module Bass::Algorithm

  module Graph
    include Bass::Algorithm

    attr_reader :graph

    def initialize(graph)
      unless graph.kind_of? Bass::GraphBase
        raise ArgumentError.new('Works only on graphs')
      end
      @graph = graph
      super
    end

    private

    def reset
      super graph.nodes
    end

  end

end