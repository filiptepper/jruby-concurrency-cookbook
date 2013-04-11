require_relative 'calculator'

1.upto(10) do |i|
  calculator = Calculator.new(i)
  thread     = java.lang.Thread.new(calculator)

  thread.start
end