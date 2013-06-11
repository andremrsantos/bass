require 'bass/algorithm'
require 'bass/property'
require 'bass/data/graph'

module Bass::Algorithm

  class GraphAlgorithm < Base
    include Property::Collection
    attr_reader :graph

    def initialize(graph)
      unless graph.kind_of? Bass::GraphBase
        raise ArgumentError.new('Works only on graphs')
      end
      @graph = graph
      super()
    end

    def to_s
      "#{super}\n" << _properties.map{|k,v| 'Node %5s : %s' % [k, v]}.join("\n")
    end

    def report_data
      { graph_order: graph.order, graph_size: graph.size }
    end

    private

    def reset
      reset_properties(graph.nodes)
    end

  end

end

require 'bass/algorithm/graph/generator'
require 'bass/algorithm/graph/mst'
require 'bass/algorithm/graph_search'
require 'bass/algorithm/graph/eccentricity'
require 'bass/algorithm/graph/cyclic'
require 'bass/algorithm/graph/flow'
