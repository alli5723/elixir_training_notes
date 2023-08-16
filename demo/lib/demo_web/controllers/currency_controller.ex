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
    case Demo.Workflows.ListAllCurrencies.run() do
      {:ok, currencies} ->
        json(conn, currencies)
      {:error, reason} ->
        conn
        |> put_status(:bad_request)
        |> json(%{error: reason})
    end
  end

  # TODO: Improve the documentation for this function
  # TODO: Add explicit type for the function parameters change map() to actual type
  @type pair_type :: %{to: String.t(), from: String.t()}
  @spec list(Plug.Conn.t(), pair_type) :: Plug.Conn.t()
  def get_rate(conn, %{"to" => to, "from" => from}) do
    rate = RatesWorker.get_rate(from, to)

    response = %{
      from: from,
      to: to,
      rate: rate
    }

    json(conn, response)
  end

  def get_rate(conn, _params) do
    conn
    |> put_status(:bad_request)
    |> json(%{error: "Invalid parameters, please proved 'to' and 'from' in payload body"})
  end

end
