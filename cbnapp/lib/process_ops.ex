defmodule App.ProcessOps do
  # CAPTURE OPERATOR

  def server do
    IO.inspect("Server is running on #{inspect(self())}")

    receive do
      {:balance, user_id, pid} ->
        user_balance =
          App.BankStatements.run(user_id, &App.UserReporter.print_balance/1)

        IO.inspect("Sending balance to #{inspect(pid)}")
        send(pid, {:balance, user_balance})
        server()

      {:social_inference, user_id, pid} ->
        user_balance =
          App.BankStatements.run(user_id, &App.UserReporter.print_social_inference/1)

        IO.inspect("Sending social inference to #{inspect(pid)}")
        send(pid, {:social_inference, user_balance})
        server()

      {:exit, pid} ->
        IO.inspect("Exiting #{inspect(self())}")
        send(pid, {:exit, self()})
        Process.exit(self(), :shutdown)
    end
  end

  def client do
    IO.inspect("Client is running #{inspect(self())}")

    server_pid = spawn(&App.ProcessOps.server/0)

    server_status_check(server_pid)

    send(server_pid, {:balance, 1, self()})
    receive do
      {:balance, balance} ->
        IO.inspect("Received balance #{inspect(balance)}")
    end

    send(server_pid, {:social_inference, 1, self()})
    receive do
      {:social_inference, social_inference} ->
        IO.inspect("Received social inference #{inspect(social_inference)}")
    end

    send(server_pid, {:exit, self()})
    receive do
      {:exit, pid} ->
        IO.inspect("Received Exit signal from #{inspect(pid)}")
    end

    server_status_check(server_pid)
  end

  defp server_status_check(server_pid) do
    case Process.alive?(server_pid) do
      true -> IO.inspect("Server is alive")
      false -> IO.inspect("Server is dead")
    end
  end
end
