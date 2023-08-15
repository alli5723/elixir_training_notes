defmodule Demo.RatesSupervisor do
  use Supervisor
  # TODO: Add module documentation

  alias Demo.Workers.RatesWorker
  def start_link(_init_) do
    Supervisor.start_link(__MODULE__, nil, name: __MODULE__)
  end

  @impl true
  def init(_init_arg) do
    children = [
    %{
      id: FiatRatesWorker,
      start: {RatesWorker, :start_link, [[{"EUR", "GBP"}, {"EUR", "USD"}, {"USD", "NGN"}]]},
      restart: :transient,
      type: :worker
    },
    # %{
    #   id: CryptoRatesWorker,
    #   start: {RatesWorker, :start_link, [[{"BTC", "GBP"}]]}
    # }
  ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
