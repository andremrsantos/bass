require 'bass/time_report'

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

      def to_s
        "<#{self.class}>"
      end

      def self.benchmark(repetition = 100, *args)
        description = "#{self} benchmark with " 
        description << args.map { |arg| arg.inspect }.join(';')
        TimeReport.new(description, repetition) { self.new(*args).execute }
      end

      private

      def reset
        raise NotImplementedError.new('#reset must be implemented')
      end

    end

  end

end