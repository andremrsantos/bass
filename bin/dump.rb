lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'bass/algorithm/graph_algorithm'
require 'bass/data/graph'

graph = Bass::Digraph.new
graph.add_node(:source)
graph.add_node(:exit)
(1..4).each { |i| graph.add_node(i) }
graph.add_edge(:source, 1, 50)
graph.add_edge(:source, 3, 40)
graph.add_edge(1, 2, 60)
graph.add_edge(3, 4, 60)
graph.add_edge(3, 2, 70)
graph.add_edge(2, :exit, 30)
graph.add_edge(4, :exit, 50)

puts graph

flow = Bass::Algorithm::MaxFlow.new(graph)
puts flow.execute
puts flow