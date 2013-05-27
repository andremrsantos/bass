require 'bass/property'

module Bass

  class TimeReport
    include Property::Simple

    attr_reader :description, :repetition, :data
    properties min: nil, max: nil, avg: nil, dev: nil

    def initialize(description, repetition = 100, &block)
      super()
      @description = description
      @repetition  = Integer(repetition)
      @block = block
      @data = []
      process
    end

    def process
      @data = (1..repetition).map { TimeReport.time(&@block) }
      process_avarage
      process_deviation
      process_min
      process_max
    end

    def process_avarage
      set_avg(@data.reduce(:+)/repetition)
    end

    def process_deviation
      process_avarage if avg.nil?
      set_dev(@data.map{ |x| (x - avg)**2 }.reduce(:+) / (repetition - 1))
    end

    def process_min
      set_min(@data.min)
    end

    def process_max
      set_max(@data.max)
    end

    def to_s(header = true)
      line   = "%5s\t%5s\t%5s\t%5s\t%5s\t%5s\n"
      string = ''
      string << line % ['DESC', 'N', 'MIN', 'MAX', 'AVG', 'DEV'] if header
      string << line % [description, repetition, min, max, avg, dev]
    end

    def self.time
      start = Time.now
      yield
      Time.now - start
    end

  end

end