defmodule Demo.XeAPI do
  require Logger

  @api_url "https://xecdapi.xe.com/v1"

  def list_currencies do
    Logger.info("Listing currencies with xe_api")
    endpoint = @api_url <> "/currencies"

    endpoint
    |> HTTPoison.get([], http_options())
    |> handle_http_response()
  end

  # function guard
  def get_rate(from, to \\ "EUR") when is_binary(from) and is_binary(to) do
    Logger.info("Getting rate with xe_api FROM: #{from}  TO: #{to}")
    params = URI.encode_query(%{from: from, to: to})
    endpoint = @api_url <> "/convert_from?" <> params

    endpoint
    |> HTTPoison.get([], http_options())
    |> handle_http_response()
  end

  def get_rate(_, _), do: {:error, "Invalid `from` arg ISO"}

  defp handle_http_response({:ok, %HTTPoison.Response{body: body}}) do
    case Jason.decode!(body) do
      %{"to" => [%{"mid" => rate} | _]} ->
        {:ok, rate}

      error ->
        Logger.error("Xe communication failure #{inspect(error)}", error: error)
        {:error, "Unexpected response from XE"}
    end
  end

  defp handle_http_response({:error, %HTTPoison.Error{reason: reason}}) do
    Logger.error("Xe communication failure #{inspect(reason)}", reason: reason)

    {:error, "Unexpected response from XE"}
  end

  defp http_options() do
    [hackney: [basic_auth: {"altecode756174953", "k8q9fic8ch01hbnern7fs2fqdl"}]]
  end
end
