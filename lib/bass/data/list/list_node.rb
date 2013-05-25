require 'bass/data/node'

module Bass::ListBase

  class SingleLinkNode < Bass::Node

    attr_reader :right

    def initialize(value, right = nil)
      super(value)
      @right = right
    end

    def append(value)
      @right = build(value, right)
      self
    end

    def prepend(value)
      build(value, self)
    end

    def pop
      @right
    end

    def inspect
      join(' -> ')
    end

    def each(&block)
      node = self
      begin
        block.call(node)
        node = node.right
      end until node.nil? || node.eql?(self)
    end

    def collect(&block)
      arr = []
      each { |node| arr << block.call(node) }
      arr
    end

    def join(delimiter = ',')
      collect { |n| n }.join(delimiter)
    end

    private

    def build(value, right = nil)
      case value
      when SingleLinkNode then value.send(:append_to_last, right)
      else SingleLinkNode.new(value, right)
      end
    end

    def last_node
      nxt = self
      nxt = nxt.right while nxt.right && !nxt.right.eql?(self)
      nxt
    end

    def append_to_last(value)
      last_node.instance_variable_set(:@right, value)
      self
    end

  end

  class DoubleLinkNode < SingleLinkNode

    attr_reader :left

    def initialize(value, left = nil, right = nil)
      super(value, right)
      @left = left
    end

    def append(value)
      self
    end

    def connect(left, right)
      last = last_node
      left.instance_variable_set(:@right, self) if left
      right.instance_variable_set(:@left, last) if right
      last.instance_variable_set(:@right, right)
      @left = left
    end

    private

    def build(value, left = nil, right = nil)
      case value
      when DoubleLinkNode
        value.append(right)
        value.prepend(left)
      else DoubleLinkNode.new(value, left, right)
      end
    end

  end

  class CircularLinkNode < DoubleLinkNode

    def initialize(value, left = self, right = self)
      super
    end

  end

end