module Bass
  module Comparator

    def self.compare(a,b)
      a <=> b
    end

    def self.less?(a, b)
      compare(a,b) < 0
    end

    def self.more?(a, b)
      compare(a,b) > 0
    end

    def self.get(compartor = :min)
      method = (compartor == :min)? :less? : :more?
      Bass::Comparator.method(method).to_proc
    end

  end
