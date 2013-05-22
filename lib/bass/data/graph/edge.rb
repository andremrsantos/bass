module Bass::Graph

	class Edge
		include Comparable

		attr_reader :weight

		def initialize(one, other, weight = 1.0)
			@one, @other = (one.hash < other.hash)? [one, other] : [other, one]
			@weight = weight
		end

		def either
			@one
		end

		def other(node)
			case node
			when @one then @other
			when @other then @one
			# TODO: Replace the following for an personalized Error.
			else raise ArgumentError.new('Invalid vertex')
			end
		end

		def nodes
			[@one, @other]
		end

		def hash
			@one.hash * 911 + @other.hash * 479
		end

		def ==(other)
			other.kind_of? self.class &&
			nodes  == other.nodes &&
			weight == other.weight  
		end

		alias_method :==, :eql?

		def <=>(other)
			# TODO: Replace the following for an personalized Error.
			raise ArgumentError.new('Uncomparable') unless other.kind_of? self.class
			weight <=> other.weight
		end
	end

	class DirectedEdge < Edge
		def initialize(one, other, weight = 1.0)
			@one = one
			@other = other
			@weigth = weight
		end

		def from
			@one
		end

		def to
			@other
		end
	end

end