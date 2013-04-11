class Calculator
  include java.lang.Runnable

  def initialize(number)
    @number = number
  end

  def run
    1.upto(10) do |i|
      printf(
        "%s: %d * %d = %d\n",
        java.lang.Thread.currentThread().getName(),
        @number,
        i,
        i * @number
      )
    end
  end
end

1.upto(10) do |i|
  calculator = Calculator.new(i)
  thread     = java.lang.Thread.new(calculator)

  thread.start
end