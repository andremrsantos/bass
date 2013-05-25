module Bass

  module Algorithm

    class Base

      def initialize
        reset
      end

      def execute
        reset
        execute!
      end

      def execute!
        raise NotImplementedError.new('#execute must be implemented')
      end

      protected

      def reset(ids = [])
        @attrs = {}
        ids.each do |id|
          @attrs[id] = default.clone
        end
      end

      def default
        @default or {}
      end

      def get(id, attribute)
        @attrs[id] and @attrs[id][attribute]
      end

      def set(id, attribute, value)
        @attrs[id] and @attrs[id][attribute] = value
      end

      def self.default_attr(attrs_hash)
        @default = attrs_hash
        attrs = attrs_hash.keys
        attrs.each do |attribute|
          set_method = "set_#{attribute}"
          define_method(attribute.to_s) { |id| get(id, attribute) }
          define_method(set_method) { |id, value| set(id, attribute, value) }
          private set_method
        end
      end
    end

  end

end

require 'bass/algorithm/graph_algorithm'