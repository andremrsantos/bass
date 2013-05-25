require 'delegate'

module Bass

  class Node < SimpleDelegator

    def initialize(value)
      super
    end

    alias_method :value, :__getobj__

    def eql?(other)
      other.object_id == object_id
    end

  end

end