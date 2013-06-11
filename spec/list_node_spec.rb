require 'rspec'
require 'bass/data/list'

describe Bass::ListBase::SingleLinkNode do
  let(:node_a) { described_class.new(1) }
  let(:node_b) { described_class.new(2) }

  it 'can append and prepend values' do
    node_a.append(2)
    node_a.right.should == 2
    node_a.prepend(0).right.should == 1
  end

  it 'can append and prepend nodes' do
    node_a.append(node_b)
    node_a.right.should == node_b
    node_a.prepend(node_b)
    node_b.right.should == node_a
  end

end