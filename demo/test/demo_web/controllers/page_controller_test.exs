defmodule DemoWeb.PageControllerTest do
  use DemoWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
    assert html_response(conn, 200) =~ "Peace of mind from prototype to production"
  end

  test "1 + 1" do
    sum = 1 + 1
    assert sum = 2
  end
end
