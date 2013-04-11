java_import 'java.util.concurrent.TimeUnit'
java_import 'java.lang.InterruptedException'
java_import 'java.lang.System'

class PrimeGenerator < java.lang.Thread
  def run
    number = 1

    while true do
      if is_prime(number)
        System.out.printf("Number %d is Prime\n", number)
      end

      if isInterrupted()
        System.out.printf("The Prime Generator has been Interrupted\n")
        return
      end

      number += 1
    end
  end


  private


  def is_prime(number)
    if number <= 2
      return true
    end

    2.upto(number - 1) do |i|
      if number % i == 0
        return false
      end
    end

    return true
  end
end

task = PrimeGenerator.new
task.start()

begin
  TimeUnit::SECONDS.sleep(5)
rescue InterruptedException => e
  e.printStackTrace()
end

task.interrupt()