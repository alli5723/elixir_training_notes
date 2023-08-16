defmodule Demo.XeAPI do
  require Logger

  @api_url "https://xecdapi.xe.com/v1"

  def list_currencies do
    endpoint = @api_url <> "/currencies"

    endpoint
    |> HTTPoison.get([], http_options())
    |> handle_http_response()
    |> case do
      {:ok, data} -> data
      _ -> nil
    end
  end

  # function guard
  def get_rate(from, to \\ "EUR") when is_binary(from) and is_binary(to) do
    params = URI.encode_query(%{from: from, to: to})
    endpoint = @api_url <> "/convert_from?" <> params

    endpoint
    |> HTTPoison.get([], http_options())
    |> handle_http_response()
    |> case do
      {:ok, %{"to" => [%{"mid" => rate} | _]}} -> {:ok, rate}
      _ -> {:error, "Invalid response from XE"}
    end
  end

  def get_rate(_, _), do: {:error, "Invalid `from` arg ISO"}

  defp handle_http_response({:ok, %HTTPoison.Response{body: body, status_code: code}}) when code in [200, 201] do
    Jason.decode(body)
  end

  defp handle_http_response({:ok, %HTTPoison.Response{body: body, status_code: _}}) do
    reason = Jason.decode!(body)
    Logger.error("Xe communication failure #{inspect(reason)}", reason: reason)
    {:error, "Xe communication failure"}
  end

  defp handle_http_response({:error, %HTTPoison.Error{reason: reason}}) do
    Logger.error("Xe communication failure #{inspect(reason)}", reason: reason)
    {:error, "Xe communication failure"}
  end

  defp http_options() do
    [hackney: [basic_auth: {"rohehand696915617", "trsfe736dftcm83cvp168mugr"}]]
  end
end
