module Property

  module BaseMethods

    def default
      (@_properties and @_properties.clone) or parent_default or {}
    end

    private

    def parent_default
      parent = self.ancestors[1]
      parent.default unless [Simple, Collection].include?(parent)
    end

  end

  module Simple
    def initialize(*var)
      reset_properties
      super(*var) if super.respond_to?(:initialize)
    end

    def reset_properties
      @_properties = self.class.default
    end

    protected

    def get(attribute)
      @_properties[attribute]
    end

    private

    attr_reader :_properties

    def set(attribute, value)
      return nil unless @_properties.has_key?(attribute)
      @_properties[attribute] = value
    end

    module ClassMethod
      include BaseMethods

      def properties(attr_hash)
        @_properties = attr_hash.merge(self.default)
        attr_hash.each_key do |attribute|
          set_method = "set_#{attribute}"
          define_method(attribute.to_s) { get(attribute) }
          define_method(set_method) { |value| set(attribute, value) }
          private set_method
        end
      end

    end

    def self.included(other)
      other.extend(Simple::ClassMethod)
    end
  end

  module Collection

    def initialize(*var)
      reset_properties()
      super(*var) if super.respond_to?(:initialize)
    end

    def reset_properties(id_or_ids = nil)
      @_properties = {}
      Array(id_or_ids).each { |id| @_properties[id] = self.class.default }
    end

    protected

    def get(id, attribute)
      @_properties[id] and @_properties[id][attribute]
    end

    private

    attr_reader :_properties

    def set(id, attribute, value)
      return nil unless  @_properties[id]
      @_properties[id][attribute] = value
    end

    module ClassMethod
      include BaseMethods

      def properties(attr_hash)
        @_properties = attr_hash.merge(self.default)
        attr_hash.each_key do |attribute|
          set_method = "set_#{attribute}"
          define_method(attribute.to_s) { |id| get(id, attribute) }
          define_method(set_method) { |id, value| set(id, attribute, value) }
          private set_method
        end
      end

    end

    def self.included(other)
      other.extend(Collection::ClassMethod)
    end

  end

end