module Bass::Algorithm

  class GraphSearch < GraphAlgorithm
    properties color: :white, parent: nil, enter_time: 0, exit_time: 0
    
    def initialize(graph, &block)
      super(graph)
      @block = block
    end

    private

    def reset
      super
      @time = 0
    end

    protected

    attr_reader :time

    def enter(node)
      set_color(node, :gray)
      set_enter_time(node, @time += 1)
    end

    def exit(node)
      set_color(node, :black)
      set_exit_time(node, @time += 1)
      @block.call(node) if @block
    end
  end 

end

require 'bass/algorithm/graph/bread_first_search'
require 'bass/algorithm/graph/depth_first_search'