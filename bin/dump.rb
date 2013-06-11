module A

  def new(*args, &block)
    instance = super
    puts '---> AT NEW'
    instance.instance_variable_set(:@tmp, 'hi')
    puts instance.instance_variable_get(:@tmp)
    instance
  end

end

class B
  extend A

  def initialize(lalala = 10)
    puts lalala
    puts @tmp.inspect
  end

end

class C < B

  def initialize
    puts @tmp
  end

end

puts '-------B-------'
B.new
puts '-------C-------'
C.new