module Bass::Graph

	# Basic Graph bidirectional edge implementation.
	# 
	# @attr_reader weight [Float] 
	class Edge
		include Comparable

		attr_reader :weight

		# Basic edge constructor, that represents a bidirectional link between
		# two nodes.
		#
		# @param one   [Object] one of the connected label.
		# @param other [Object] other of the connected label.
		# @param weight [Float] the edge weight.
		# @return self
		def initialize(one, other, weight = 1.0)
			@one, @other = (one.hash < other.hash)? [one, other] : [other, one]
			@weight = weight
		end

		# @return [Object] one of the nodes linked by the edge.
		def either
			@one
		end

		# @param node [Object] one of the nodes linked by the edge.
		# @return [Object] the other node linked by the edge.
		# @raise ArgumentError if the node is not linked by the edge.
		def other(node)
			case node
			when @one then @other
			when @other then @one
			# TODO: Replace the following for an personalized Error.
			else raise ArgumentError.new('Invalid vertex')
			end
		end

		# @return [Array] set of node linked
		def nodes
			[@one, @other]
		end

		# @return [Integer] an hash number to represent the edge in HashTable
		def hash
			@one.hash * 911 + @other.hash * 479
		end

		# @param other [Object] the object to be compared to self
		# @return [true, false] if the object is the same class, link the same 
		# 	nodes and has the same weight
		def ==(other)
			eql? other && weight == other.weight
		end

		# @param other [Object] the object to be compared to self
		# @return [true, false] if the object is the same class and link 
		# 	the same nodes
		def eql?(other)
			other.kind_of? self.class &&
			nodes  == other.nodes
		end

		# @param other [Edge] the other edge to be compared.
		# @return [Integer]   the weight comparison: -1 if less, 0 if equal and 
		# 	1 if more
		def <=>(other)
			# TODO: Replace the following for an personalized Error.
			raise ArgumentError.new('Uncomparable') unless other.kind_of? Edge
			weight <=> other.weight
		end
	end

	# Basic Graph directional edge implementation.
	class DirectedEdge < Edge
		# Basic directional edge constructor, that represents a directional 
		# link between two nodes.
		#
		# @param from [Object] origin node.
		# @param to   [Object] destination node.
		# @param weight [Float] the edge weight.
		# @return self
		def initialize(from, to, weight = 1.0)
			@one = from
			@other = to
			@weigth = weight
		end

		# @return [Object] the origin node
		def from
			@one
		end

		# @return [Object] the destination node
		def to
			@other
		end
		
	end

end