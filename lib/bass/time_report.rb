require 'bass/property'

module Bass

  class TimeReport
    include Property::Simple

    attr_reader :description, :repetition, :data
    properties min: nil, max: nil, avg: nil, dev: nil

    def initialize(description, algo, repetition = 100, &block)
      super()
      @description = description
      @args = get_report_data(algo)
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
      "%s\t%s\t%s\t%s\t%s\t%s\t%s\n" % [description, repetition, min, max, avg, dev, data_s]
    end

    def self.time
      start = Time.now
      yield
      Time.now - start
    end

    private

    def get_report_data(obj)
      if obj.kind_of?(Hash)
        obj
      elsif obj.respond_to?(:report_data) 
        obj.report_data
      else 
        { arg: obj.inspect }
      end
    end

    def data_s
      @args.values.join("\t")
    end

  end

end