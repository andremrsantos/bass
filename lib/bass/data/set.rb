# @author  André M. Ribeiro-dos-Santos
# @version 0.0.1

require 'forwardable'

module Bass

  # Set is an unordered collection of items that do not have repetition.
  class Set
    extend Forwardable
    def_delegator :@items, :size

    # Construct the Set including a list of items informed.
    # 
    # @param items [Array] List of items to be included to the set. 
    # @return [Set] the instance of Set
    def initialize(*items)
      @items = {}
      items.each {|item| merge(item)}
    end

    # Return the item stored equal to the one stored.
    # 
    # @param item [Object] Item to be looked in the set
    # @return [Object] the correspondent item
    def get(item)
      @items[item]
    end

    # Insert an item to the Set.
    # 
    # @param item [Object] Item to be inserted.
    # @return [Set] the instance
    def push(item)
      @items[item] = item unless include?(item)
      self
    end

    # Remove an item from the Set.
    # 
    # @param item [Object] Item to be removed
    # @return [Object] the removed item
    def pull(item)
      @items.delete(item) if include?(item)
    end

    # Verifies if the Set include an given item.
    # 
    # @param item [Object] Item to be verified
    # @return [true]  if the *item* is present
    # @return [false] if the *item* is not present
    def include?(item)
      ! get(item).nil?
    end

    # Iterator for every item present in the Set.
    # 
    # @return [Set] the current instance 
    def each(&block)
      @items.each_key(&block)
      self
    end

    # Returns the items present as an Array
    def to_a
      @items.keys
    end

    # Merge other Enumerable or Object into the present Set.
    # 
    # @param other [Enumerable, Object] Collections of items to be included
    # @return [Set] the current instance
    def merge(other)
      case other
      when Enumerable then other.each{ |item| push(item) }
      else push(other)
      end
      self
    end

    def clone
      clone = super
      items = {}
      each { |item| items[item] = @items[item].clone }
      clone.instance_variable_set(:@items, items)
      clone
    end

  end

end