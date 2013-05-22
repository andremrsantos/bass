# @author André M. Ribeiro dos Santos
# @version 0.0.1

require 'data/set'

module Graph

	# Module to represent an Graph as queue of edges.
	module EdgesQueue

		private

		# Create a new *Node* model
		def new_node
			{ attr: {}, edges: Set.new }	
		end

		def connect(from, to, weight = 1.0)
			@nodes[from][:edges].add new_edge(from, to, weigth)
		end

		def disconnect(from, to)
			@nodes[from][:edges].remove new_edge(from, to)
		end
	end

end