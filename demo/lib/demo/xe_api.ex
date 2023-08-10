defmodule Demo.XeAPI do
  require Logger

  @api_url "https://xecdapi.xe.com/v1"

  def list_currencies do
    endpoint = @api_url <> "/currencies"

    endpoint
    |> HTTPoison.get([], http_options())
    |> handle_http_response()
  end

  # function guard
  def get_rate(from, to \\ "EUR") when is_binary(from) and is_binary(to) do
    params = URI.encode_query(%{from: from, to: to})
    endpoint = @api_url <> "/convert_from?" <> params

    %{"to" => [%{"mid" => rate} | _]} =
      endpoint
      |> HTTPoison.get([], http_options())
      |> handle_http_response()

    rate
  end

  def get_rate(_, _), do: {:error, "Invalid `from` arg ISO"}

  defp handle_http_response(http_response) do
    case http_response do
      {:ok, %HTTPoison.Response{body: body}} ->
        Jason.decode!(body)

      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error("Xe communication failure #{inspect(reason)}", reason: reason)
    end
  end

  defp http_options() do
    [hackney: [basic_auth: {"altecode756174953", "k8q9fic8ch01hbnern7fs2fqdl"}]]
  end
end
