defmodule Cbnapp do
  # spawn and spawn_link
  def receive_greetings do
    receive do
      :ping ->
        IO.inspect "PONG"
        receive_greetings()

      :hey ->
        IO.inspect :no_respect
        receive_greetings()

      :exit ->
        IO.inspect "Exiting"
        :ok
    end
  end
  def print_my_proccess_id do
    IO.puts "My process id is #{inspect self()}"
  end

  def is_country_the_best?("NG") do
    true |> IO.inspect()
  end

  def is_country_the_best?(_) do
    "We really cant say" |> IO.inspect()
  end

  def call_multiple_processes do
    # pid1 = spawn(Cbnapp, :print_my_proccess_id, [])
    # pid2 = spawn(Cbnapp, :print_my_proccess_id, [])
    # pid3 = spawn(Cbnapp, :print_my_proccess_id, [])
  end

  def hello do
    :world
  end
end
