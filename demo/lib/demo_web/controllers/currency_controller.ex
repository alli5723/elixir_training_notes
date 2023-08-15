defmodule DemoWeb.CurrencyController do
  use DemoWeb, :controller
  alias Demo.ExchangeWorker
  alias Demo.Workers.RatesWorker
  @moduledoc """
  CurrencyController provides a JSON API for the currency exchange.

  Two public functions are available:
  - list: returns a list of all available currencies
  - get_rate: returns the exchange rate between two currencies
  """

  @spec list(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def list(conn, _params) do
    currencies = ExchangeWorker.list_currencies()
    json(conn, currencies)
  end

  # TODO: Improve the documentation for this function
  # TODO: Add explicit type for the function parameters change map() to actual type
  @spec list(Plug.Conn.t(), map()) :: Plug.Conn.t()
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
