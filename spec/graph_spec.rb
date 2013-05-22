require 'rspec'
require 'bass/data/graph'

shared_examples 'a graph' do
  let(:graph) { described_class.new.add_node(1).add_edge(1,1) }

  it 'can insert an node' do
    graph.order.should == 1
    graph.has_node?(1).should be_true
    graph.nodes.include? 1
  end

  it 'can remove an node' do
    graph.remove_node 1
    graph.order.should == 0
    graph.has_node?(1).should be_false
  end

  it 'can insert edges' do
    graph.size.should == 1
    graph.has_edge?(1,1).should be_true
  end

  it 'can remove edges' do
    graph.remove_edge(1,1)
    graph.size.should == 0
    graph.has_edge?(1,1).should be_false
  end

  it 'can remove all edges with node' do
    graph.add_node(2)
    graph.add_edge(2,1)
    graph.size.should == 2
    graph.order.should== 2
    graph.remove_node 1
    graph.size.should == 0
    graph.order.should== 1
  end

  it 'can iterate all nodes' do
    graph.each_node do |node|
      node.should == 1
    end
  end

  it 'can iterate all edges' do
    graph.each_edge do |edge|
      edge.either.should == 1
    end
  end

end

describe Bass::Graph do
  let(:graph) { described_class.new.add_node(1).add_edge(1,1) }

  it_behaves_like 'a graph'

  it 'knows the degree' do
    graph.degree(1).should == 1
  end
end

describe Bass::Digraph do
  let(:graph) { described_class.new.add_node(1).add_edge(1,1) }

  it_behaves_like 'a graph'

  it 'knows the degree' do
    graph.in_degree(1).should == 1
    graph.out_degree(1).should == 1
    graph.degree(1).should == 2
  end

  it 'is transposable' do
    graph.add_node(2).add_edge(2,1)
    transpose = graph.transpose
    graph.each_node { |node| transpose.has_node?(node).should be_true }
    graph.each_edge { |edge| transpose.has_edge?(edge.to, edge.from)}
  end

end