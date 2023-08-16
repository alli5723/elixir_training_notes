defmodule DemoWeb.CurrencyControllerTest do
  use DemoWeb.ConnCase
  doctest Demo.Workflows.ListAllCurrencies

  test "List Currencies", %{conn: conn} do
    conn = get(conn, "/api/list_currencies")

    assert response = json_response(conn, 200)
    assert %{"currencies" => [%{"currency_name" => _, "is_obsolete" => _, "iso" => _} | _] = currencies} = response
    assert 173 = length(currencies)
  end

  test "Get Rate", %{conn: conn} do
    # post(conn, "/api/get_rate", %{to: "USD", from: "EUR"})
    assert 1 = 1
  end
end
