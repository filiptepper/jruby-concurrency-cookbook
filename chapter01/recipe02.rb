require_relative 'calculator'

java_import 'java.io.IOException'
java_import 'java.io.FileWriter'
java_import 'java.io.PrintWriter'

def writeThreadInfo(writer, thread, state)
  writer.printf("Main: Id %d - %s\n", thread.getId(), thread.getName())
  writer.printf("Main: Priority: %d\n", thread.getPriority())
  writer.printf("Main: Old State: %s\n", state)
  writer.printf("Main: New State: %s\n", thread.getState())
  writer.printf("Main: ************************************\n")
end

printf("Minimum Priority: %s\n", java.lang.Thread::MIN_PRIORITY)
printf("Normal Priority: %s\n",  java.lang.Thread::NORM_PRIORITY)
printf("Maximum Priority: %s\n", java.lang.Thread::MAX_PRIORITY)

threads = []
status  = []

0.upto(9) do |i|
  threads[i] = java.lang.Thread.new(Calculator.new(i))

  if i % 2 == 0
    threads[i].setPriority(java.lang.Thread::MAX_PRIORITY)
  else
    threads[i].setPriority(java.lang.Thread::MIN_PRIORITY)
  end

  threads[i].setName("Thread #{i}")
end

begin
  file   = FileWriter.new('./log.txt')
  writer = PrintWriter.new(file)

  0.upto(9) do |i|
    writer.println("Main: Status of Thread #{i}: #{threads[i].getState()}")
    status[i] = threads[i].getState()
  end

  0.upto(9) do |i|
    threads[i].start()
  end

  finish = false

  while !finish
    0.upto(9) do |i|
      if threads[i].getState() != status[i]
        writeThreadInfo(writer, threads[i], status[i])
        status[i] = threads[i].getState()
      end
    end

    finish = true

    0.upto(9) do |i|
      finish = finish && threads[i].getState() == java.lang.Thread::State::TERMINATED
    end
  end

  writer.flush()
rescue IOException => e
  e.printStackTrace()
end