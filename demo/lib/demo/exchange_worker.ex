defmodule Demo.ExchangeWorker do
  use GenServer

  def start_link(_init) do
    GenServer.start_link(Demo.ExchangeWorker, nil, name: __MODULE__)
  end

  ## Client
  def list_currencies() do
    GenServer.call(__MODULE__, :list_currencies)
  end


  ## Servers
  def init(_initial_value) do
    # currencies = Demo.XeAPI.list_currencies()
    # new_state = Map.put(%{}, :currencies, currencies)
    {:ok, %{}, {:continue, :load_currencies}}
  end

  def handle_call(:list_currencies, _from, state) do
    currencies = Map.get(state, :currencies)

    {:reply, currencies, state}
  end

  def handle_continue(:load_currencies, state) do
    currencies = Demo.XeAPI.list_currencies()

    new_state = Map.put(state, :currencies, currencies)
    {:noreply, new_state}
  end
end
