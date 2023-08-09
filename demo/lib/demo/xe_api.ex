defmodule Demo.XeAPI do
  require Logger

  @api_url "https://xecdapi.xe.com/v1"

  def list_currencies do
    endpoint =  @api_url <> "/currencies"

    options = [hackney: [basic_auth: {"altecode756174953", "k8q9fic8ch01hbnern7fs2fqdl"}]]

    endpoint
    |> HTTPoison.get([], options)
    |> case do
      {:ok, %HTTPoison.Response{body: body}} ->
        handle_response_body(body)
      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error("Xe communication failure #{inspect(reason)}", reason: reason)
      end
  end

  defp handle_response_body(response_body) do
    case Jason.decode(response_body) do
      {:ok, decoded_body} ->
        decoded_body
      {:error, json_error} ->
        :error
    end
  end
end
