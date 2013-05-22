require 'rspec'
require 'bass/data/graph'

describe Bass::Graph::Node::QueueNode do
	let(:edge) { Bass::Graph::Edge.new(1,2) }
	let(:node) { Bass::Graph::Node::QueueNode.new(1).push_edge edge }

	it 'append a edge' do
		node.degree.should == 1
	end

	it 'remove a edge' do
		node.pull_edge edge
		node.degree.should == 0
	end

	it 'list edges' do
		node.edges.should == [edge]
	end
end

describe Bass::Graph::Node::AdjacencyNode do
	let(:node) { Bass::Graph::Node::AdjacencyNode.new() }
	let(:edge) { Bass::Graph::Edge.new(node.label, 2) }

	before { node.push_edge edge }

	it 'append a edge' do
		node.degree.should == 1
	end

	it 'remove a edge' do
		node.pull_edge edge
		node.degree.should == 0
	end

	it 'list edges' do
		node.edges.should == [edge]
	end
end