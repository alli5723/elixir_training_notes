defmodule Demo.FakeExchangeWorker do
  def list_currencies() do
    __DIR__
    |> Path.join("../fixtures/currency_list.json")
    |> File.read!()
    |> Jason.decode!()
  end
end
