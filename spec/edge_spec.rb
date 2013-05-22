require 'rspec'
require 'bass/data/graph'

describe Bass::GraphBase::Edge do
  let(:edge_a) { Bass::GraphBase::Edge.new(1, 2, 10) }
  let(:edge_b) { Bass::GraphBase::Edge.new(2, 1, 5) }

  it 'is comparable' do
    edge_a.should == edge_b
    edge_a.should > edge_b
  end

  it 'recognize edges' do
    edge_a.other(1).should == 2
    edge_a.other(2).should == 1
  end

  it 'is hashable' do
    hash = { edge_a => 0 }
    hash[edge_b].should == 0
  end

end

describe Bass::GraphBase::DirectedEdge do
  let(:edge_a) { Bass::GraphBase::DirectedEdge.new(1, 2) }
  let(:edge_b) { Bass::GraphBase::DirectedEdge.new(2, 1) }

  it 'diferenciate source and destiny' do
    edge_a.should_not == edge_b
  end

  it 'has source and destiny' do
    edge_a.from.should == 1
    edge_a.to.should == 2
  end

  it 'is hashable' do
    hash = { edge_a => 0 }
    hash[edge_b].should_not == 0
  end

end