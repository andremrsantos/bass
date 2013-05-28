lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'bass/data/graph'
require 'bass/algorithm/graph_algorithm'
require 'bass/algorithm/graph_search'

tree = Bass.tree_generator(20, 2)

puts '---Árvore Base---'
puts tree
puts
puts '---Q02---'

puts '---Tabela de Excentricidade---'
puts
puts ecc = Bass.eccentricity(tree)
puts '---Centro---'
puts ecc.center.inspect
puts '---Posto---'
puts ecc.post
puts '---Performace---'
# # Variando ordem
# (1..50).each do |fac|
#   tree = Bass.tree_generator(fac*5, 5)
#   puts Bass::Algorithm::Eccentricity.benchmark(50, tree)
#   puts Bass::Algorithm::EccentricityTree.benchmark(50, tree)
# end
puts '---Q04---'

graph = Bass::Graph.new()
%w(a b c d e f).each { |node| graph.add_node(node) }
graph.add_edge('a','b', 3)
graph.add_edge('a','c', 8)
graph.add_edge('a','e', 5)
graph.add_edge('b','e', 5)
graph.add_edge('b','d', 5)
graph.add_edge('c','e', 2)
graph.add_edge('c','d', 7)
graph.add_edge('c','f', 4)
graph.add_edge('d','e', 2)
graph.add_edge('d','f', 6)

puts ecc = Bass.eccentricity(graph)
puts '---Centro---'
puts ecc.center.inspect
puts '---Posto---'
puts ecc.post

puts '---Q05---'
puts tree = Bass.minimal_spanning_tree(graph, :primm)
ecc = Bass.eccentricity(tree)
puts '---Centro---'
center = ecc.center
puts center.inspect
puts '---Altura---'
puts ecc.eccentricity(center.first)
puts '---Posto---'
puts ecc.post

puts '---Q07---'
graph = Bass::Graph.new()
%w(a b c d e f g).each { |node| graph.add_node(node) }
graph.add_edge('a','b', 7)
graph.add_edge('a','d', 5)
graph.add_edge('b','d', 9)
graph.add_edge('b','c', 8)
graph.add_edge('b','e', 7)
graph.add_edge('c','e', 5)
graph.add_edge('d','e',15)
graph.add_edge('d','f', 6)
graph.add_edge('f','e', 8)
graph.add_edge('f','g',11)
graph.add_edge('e','g', 9)
puts graph
puts '---AGM---'
puts Bass.minimal_spanning_tree(graph, :primm)

puts '---Aumento de Arestas---'
edges = []
nodes = graph.nodes
(0...nodes.size).each do |i|
  ((i+1)...nodes.size).each do |j|
    u, v = nodes[i], nodes[j]
    edges << [u, v] unless graph.has_edge?(u, v)
  end
end

puts Bass::Algorithm::PrimmMST.benchmark(50, graph)
puts Bass::Algorithm::KruskalMST.benchmark(50, graph)
edges.each do |u, v|
  graph.add_edge(u, v, rand(15))
  puts Bass::Algorithm::PrimmMST.benchmark(50, graph)
  puts Bass::Algorithm::KruskalMST.benchmark(50, graph)
end