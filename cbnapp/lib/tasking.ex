defmodule App.Tasking do
  def perform do
    task = Task.async(fn -> do_some_work() end, 11000)
    execute_task()
    IO.inspect("Waiting for task to finish")
    Task.await(task)
  end

  def execute_task do
    IO.inspect("Executing task")
    :timer.sleep(1000)
    IO.inspect("Finished executing task")
  end

  def do_some_work do
    IO.inspect("Doing some work")
    :timer.sleep(10000)
    IO.inspect("Done some work")
  end
end
