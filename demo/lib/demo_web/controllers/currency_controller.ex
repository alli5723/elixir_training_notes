defmodule DemoWeb.CurrencyController do
  use DemoWeb, :controller
  alias Demo.Workers.RatesWorker

  @exchange_worker Application.compile_env(:demo, Demo.ExchangeApi)[:adapter]

  @moduledoc """
  CurrencyController provides a JSON API for the currency exchange.

  Two public functions are available:
  - list: returns a list of all available currencies
  - get_rate: returns the exchange rate between two currencies
  """

  @spec list(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def list(conn, _params) do
    currencies = @exchange_worker.list_currencies()
    json(conn, currencies)
  end

  def get_rate(conn, %{"to" => to, "from" => from} = params) do
    rate = RatesWorker.get_rate(from, to)

    response = %{
      from: from,
      to: to,
      rate: rate
    }

    json(conn, response)
  end

end
