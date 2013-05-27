require 'bass/data/set'

module Bass

	# Module with the main features to an graph behavior. Its implementations,
	# must include the following methods:
	# 	- connect(from, to, weight):
	# 		links two nodes (from and to) and return a value if successful.
	# 	- disconnect(from, to):
	# 		removes and edge (from, to) and return a value if successful
	# 	- new_edge(from, to, weight)
	# 		returns the implementation of [Edge](see Bass::Graph::Edge) used
	# 	- new_node(node)
	# 		returns the implementation of [Node](see Bass::Graph::Node) used
	#
	# @attr_reader order [Integer] the number of nodes in the graph.
	# @attr_reader size [Integer] the number of edges in the graph.
	module GraphBase
		attr_reader :order, :size

		def initialize
			@nodes = {}
			@order = 0
			@size  = 0
		end

		# @param node [Object] the queried node
		# @return [Hash] of the node attributes
		# @return [nil] if the node is not present
		def get(node)
			get_node(node).attrs unless has_node?(node)
		end

		# @param node [Object] the queried node
		# @return [Integer] the degree of the queried node
		def degree(node)
			get_node(node).degree if has_node?(node)
		end

		# @return [Float] the sum of all edges weight
		def weight
			edges.map{ |edge| edge.weight }.reduce(:+)
		end

		# @param node [Object] the queried node
		# @return [Array<Edge>] the collection of edges adjacent to the node
		def adjacent(node)
			get_node(node).edges
		end

		# @return [Array] the collection of all nodes in the graph
		def nodes
			@nodes.keys
		end

		# @return [Array<Edge>] the collection of all edges in the graph
		def edges
			set = Bass::Set.new
			each_node do |node|
				set.merge adjacent(node)
			end
			set.to_a
		end

		# Include a new node to the graph.
		#
		# @param node [Object] the label to identify the node being inserted.
		# @return [Graph] self
		def add_node(node)
			unless has_node?(node)
				@nodes[node] = new_node(node)
				@order += 1
			end
			self
		end

		# Remove a node from the graph.
		#
		# @param node [Object] the label to identify the node being removed.
		# @return [Graph] self
		def remove_node(node)
			if has_node?(node)
				pull_edges_of(node)
				@nodes.delete(node)
				@order -= 1
			end
			self
		end

		# Adds an edge connecting the nodes from and to. If the nodes does not
		# exist it creates them.
		#
		# @param from [Object] identification label of the node to be connect.
		# @param to [Object] identification label of the other label being
		# 	connected.
		# @param weight [Float] the weight of the edge.
		# @return [Graph] self
		def add_edge(from, to, weight = 1.0)
			add_node(from)
			add_node(to)
			@size += 1 if connect(from, to, weight)
			self
		end

		# Removes the edge connecting the nodes from and to.
		#
		# @param from [Object] identification label of the node to be disconnect.
		# @param to [Object] identification label of the other label being
		# 	disconnected.
		# @return [Graph] self
		def remove_edge(from, to)
			@size -= 1 if disconnect(from, to)
			self
		end

		# @param node [Object] identification label of the node being queried.
		# @return [true, false] if the graph includes the node.
		def has_node?(node)
			! get_node(node).nil?
		end

		# @param from [Object] identification label of a node.
		# @param to [Object] identification label of other node.
		# @return [true, false] if the graph connects the nodes
		def has_edge?(from, to)
			get_node(from).has_edge? new_edge(from, to)
		end

		# Interator for each node label in the graph
		def each_node(&block)
			nodes.each(&block)
		end

		# Interator for each edge in the graph
		def each_edge(&block)
			edges.each(&block)
		end

		def to_s
			"< #{self.class} >\n" << nodes.map { |node| get_node(node) }.join("\n")
		end

		def inspect
			"<#{self.class} order:#{order} size:#{size}>"
		end

		def clone
			clone = super
			nodes = {}
			each_node { |node| nodes[node] = get_node(node).clone }
			clone.instance_variable_set(:@nodes, nodes)
			clone
		end

		private
		
		# Return the node implementation instance
		def get_node(node)
			@nodes[node]
		end

		# Remove all edges related to an node.
		def pull_edges_of(node)
			each_node do |other|
				remove_edge(node, other)
				remove_edge(other, node)
			end
		end

		# Connects to nodes
		def connect
			raise NotImplementedError.new('#connect must be implemented')
		end

		# Disconnect two node
		def disconnect
			raise NotImplementedError.new('#disconnect must be implemented')
		end

		# Create a new edge instance
		def new_edge
			raise NotImplementedError.new('#new_edge must be implemented')
		end

		# Creates a new Node instance
		def new_node
			raise NotImplementedError.new('#new_node must be implemented')
		end

	end

end

require 'bass/data/graph/components/edge'
require 'bass/data/graph/components/node'
require 'bass/data/graph/structure/queue_graph.rb'
require 'bass/data/graph/structure/adjacency_graph.rb'