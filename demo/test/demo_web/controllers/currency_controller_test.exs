defmodule DemoWeb.CurrencyControllerTest do
  use DemoWeb.ConnCase
  doctest Demo.Workflows.ListAllCurrencies

  describe "Testing Currency Controller" do
    test "GET /", %{conn: conn} do
      conn = get(conn, "/api/list_currencies")
      assert response = json_response(conn, 200)

      assert %{"currencies" => currencies} = response
      assert [%{"currency_name" => _, "is_obsolete" => _, "iso" => _} | _] = currencies
      assert 173 =  length(currencies)
    end

    test "List Currencies", %{conn: conn} do
      conn = get(conn, "/api/list_currencies")

      assert response = json_response(conn, 200)
      assert %{"currencies" => [%{"currency_name" => _, "is_obsolete" => _, "iso" => _} | _] = currencies} = response
      assert 173 = length(currencies)
    end
  end
end
