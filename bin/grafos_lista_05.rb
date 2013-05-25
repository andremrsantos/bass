lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'bass/data/graph'
require 'bass/algorithm/graph_algorithm'

graph = Bass::Graph.new()
%w(a b c d e f).each { |node| graph.add_node(node) }
graph.add_edge('a','b')
graph.add_edge('a','c')
graph.add_edge('a','e')
graph.add_edge('b','e')
graph.add_edge('b','d')
graph.add_edge('c','e')
graph.add_edge('c','d')
graph.add_edge('c','f')
graph.add_edge('d','e')
graph.add_edge('d','f')

puts graph
puts
puts Bass.minimal_spanning_tree(graph, :primm)
puts 
puts Bass.minimal_spanning_tree(graph, :kruskal)