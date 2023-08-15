defmodule Demo.Workers.RatesWorker do
  use GenServer
  # TODO: Add module documentation

  def start_link(pairs_list) do
    GenServer.start_link(__MODULE__, pairs_list, name: __MODULE__)
  end

  ## Client
  # TODO: Add function documentation
  # TODO: Add typespec
  def list_rates(), do: GenServer.call(__MODULE__, :list_rates)
  # TODO: Add function documentation and typespec
  def get_rate(from, to), do: GenServer.call(__MODULE__, {:get_rate, {from, to}})

  ## Servers
  @doc """
  pairs_list [{EUR, GBP}, {EUR, USD}, {USD, NGN}]
  """
  def init([_h | _t] = pairs_list) do
    new_state = Map.new() |> Map.put(:pairs_list, pairs_list)
    {:ok, new_state, {:continue, :get_rates}}
  end

  def handle_call(:list_rates, _from, state) do
    rates = Map.get(state, :rates)

    {:reply, rates, state}
  end

  def handle_call({:get_rate, {from, to}}, _from, state) do
    rate = state |> Map.get(:rates) |> Map.get("#{from}/#{to}")

    {:reply, rate, state}
  end

  def handle_continue(:get_rates, %{pairs_list: list_of_pairs} = state) do
    pairs_rates =
      Enum.reduce(list_of_pairs, %{}, fn {from, to}, acc ->
        case Demo.XeAPI.get_rate(from, to) do
          rate when is_float(rate) ->
            Map.put(acc, "#{from}/#{to}", rate)

          _ ->
            nil
            Map.put(acc, "#{from}/#{to}", nil)
        end
      end)

    new_state = Map.put(state, :rates, pairs_rates)
    {:noreply, new_state}
  end
end
