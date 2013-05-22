require 'rspec'
require 'bass/data/graph'

describe Bass::GraphBase::Node::QueueNode do
	let(:edge) { double('edge') }
	let(:node) { Bass::GraphBase::Node::QueueNode.new(1).push_edge edge }

	it 'append a edge' do
		node.has_edge?(edge).should be_true
		node.degree.should == 1
	end

	it 'remove a edge' do
		node.pull_edge edge
		node.has_edge?(edge).should be_false
		node.degree.should == 0
	end

	it 'list edges' do
		node.edges.should == [edge]
	end

end

describe Bass::GraphBase::Node::AdjacencyNode do
	let(:edge) { double('edge', other: 'a', kind_of?: true) }
	let(:node) { Bass::GraphBase::Node::AdjacencyNode.new('a').push_edge edge }

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