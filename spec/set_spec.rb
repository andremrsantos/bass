require 'rspec'
require 'bass/data/set'

describe Bass::Set do
	let(:set) { Bass::Set.new(1,2,3) }
	subject { set }

	it 'construct with array' do
		set.include?(1).should be_true
		set.include?(2).should be_true
		set.include?(3).should be_true
		set.size.should == 3
	end

	it 'push an item' do
		set.push 4
		set.size.should == 4
		set.include?(4).should be_true
	end

	it 'do not push repeted' do
		set.push 1
		set.size.should == 3
		set.include?(1).should be_true
	end

	it 'pull an item' do
		set.pull 1
		set.size.should == 2
		set.include?(1).should be_false
	end

	it 'rescue an item' do
		set.get(1).should == 1
	end

	it 'iterable' do
		set.each { |item| [1,2,3].include?(item).should be_true}
	end

	it 'parse to Array' do
		arr = set.to_a
		arr.include?(1).should be_true
		arr.include?(2).should be_true
		arr.include?(3).should be_true
		arr.size.should == 3
	end
end