lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'bass/algorithm/graph_algorithm'
require 'bass/data/graph'

graph = Bass::Digraph.new
%i(a b c d e f g).each { |i| graph.add_node(i) }
graph.add_edge(:a, :d, 3)
graph.add_edge(:a, :b, 3)
graph.add_edge(:b, :c, 4)
graph.add_edge(:c, :d, 1)
graph.add_edge(:b, :e, 1)
graph.add_edge(:c, :e, 2)
graph.add_edge(:d, :e, 2)
graph.add_edge(:d, :f, 6)
graph.add_edge(:e, :g, 1)
graph.add_edge(:f, :g, 9)
puts graph

flow = Bass::Algorithm::MaxFlow.new(graph, :a, :g)
flow.execute
puts flow
puts

graph = Bass::Digraph.new
%i(s o p q r t).each { |i| graph.add_node(i) }
graph.add_edge(:s, :o, 3)
graph.add_edge(:s, :p, 3)
graph.add_edge(:o, :p, 2)
graph.add_edge(:o, :q, 3)
graph.add_edge(:p, :r, 2)
graph.add_edge(:q, :r, 4)
graph.add_edge(:q, :t, 2)
graph.add_edge(:r, :t, 3)
puts graph

flow = Bass::Algorithm::MaxFlow.new(graph, :s, :t)
flow.execute
puts flow
puts

graph.add_edge(:p, :t, 3)
flow = Bass::Algorithm::MaxFlow.new(graph, :s, :t)
flow.execute
puts flow
puts


graph.remove_edge(:s, :p)
graph.add_edge(:s, :p, 5)
flow = Bass::Algorithm::MaxFlow.new(graph, :s, :t)
flow.execute
puts flow
puts
