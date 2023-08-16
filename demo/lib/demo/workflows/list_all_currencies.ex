defmodule Demo.Workflows.ListAllCurrencies do
  require Logger
  alias Demo.ExchangeWorker

  @doc """
    Runs the workflow.
      iex> {:ok, %{"currencies" => curr}} = Demo.Workflows.ListAllCurrencies.run()
      iex> is_list(curr)
      true
  """
  def run() do
    Logger.info("Running ListAllCurrencies workflow")
    with %{"currencies" => _list} = currencies <- ExchangeWorker.list_currencies() do
      {:ok, currencies}
    else
      _ ->
        cached_data()
    end
  end

  @doc """
    Returns cached data.
      iex> {:ok, %{"currencies" => curr}} = Demo.Workflows.ListAllCurrencies.cached_data()
      iex> is_list(curr)
      true
  """
  def cached_data() do
    {:ok,
    %{
      "currencies" => [
        %{
          "currency_name" => "United Arab Emirates Dirham",
          "is_obsolete" => false,
          "iso" => "AED"
        }
      ]
    }}
  end
end
