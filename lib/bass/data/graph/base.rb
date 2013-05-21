module Graph

	module Base
		
		attr_reader :order, :size

		def initialize
			@nodes = {}
			@order = 0
			@size  = 0
		end

		def get(node)
			@nodes[node] unless has_node?(node)
		end
		
		def add_node(node)
			unless has_node?(node)
				@nodes[node] = new_node
				@order += 1
			end
		end

		def remove_node(node)
			# TODO remove edges
			@nodes.delete(node)
			@order -= 1
		end

		def add_edge(from, to, weight = 1.0)
			edge = new_edge(from, to, weight)

			add_node(from)
			add_node(to)
			# Assume an graph as default behavior 
			connect(from, to, weight)
			connect(to, from, weight)
		end

		def has_node?(node)
			! @nodes[node].nil?
		end

		def each_node(&block)
			@nodes.each_key(&block)
		end

		def each_edge(&block)
		end

		private

		def pull_edges_of(node)
			adjacent(node).each { |edge| remove_edge(node, edge.other(node)) }
			each_node { |other| remove_edge(other, node) }
		end

	end

end