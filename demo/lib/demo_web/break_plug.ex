defmodule Demo.BreakPlug do
  import Plug.Conn

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    conn
    |> put_resp_header("x-break-plug", "true")
    |> send_resp(200, "Hello from BreakPlug")
    |> halt()
  end

end
