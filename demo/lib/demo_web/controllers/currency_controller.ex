defmodule DemoWeb.CurrencyController do
  use DemoWeb, :controller
  alias Demo.ExchangeWorker
  alias Demo.Workers.RatesWorker

  def list(conn, _params) do
    currencies = ExchangeWorker.list_currencies()
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
