require 'data/set'

module Graph

	module EdgesQueue

		private

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