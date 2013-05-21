require 'forwardable'

module Set

	class Set
		extend Forwardable
		def_delegator :@itens, :size

		def initialize(itens=[])
			@itens = {}
			itens.each {|item| add(item)}
		end

		def get(item)
			@itens[item]
		end

		def add(item)
			@itens[item] = item unless include?(item)
		end

		def remove(item)
			@itens.delete(item) if include?(item)
		end

		def include?(item)
			! get(item).nil?
		end

		def each(&block)
			@itens.each_key(&block)
		end

		def to_a
			@itens.keys
		end

	end

end