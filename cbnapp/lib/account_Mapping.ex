defmodule App.AccountMapping do
  # PATTERN MATCHING
  @accounts [
    "ABU101222", # Abuja
    "ABI101222",
    "BAY101222",
    "BOR101222",
    "EDO101222",
    "KAN101222",
    "KWA101222",
    "LAG101222"
  ]

  def run() do
    print_account_origin()
  end

  def print_account_origin() do
    IO.inspect("Enter your account number")

    account_number = IO.gets(">>> ")
      |> String.Chars.to_string()
      |> String.trim()
    case Enum.member?(@accounts, account_number) do
      true -> IO.inspect("Your account is from #{get_state_region(account_number)} Nigeria")
      false -> IO.inspect("Your account is from another country")
    end
  end

  defp get_state_region(<<"ABU", _account::binary>>), do: "Central"

  defp get_state_region(<<state::binary-size(3), _account::binary>>)
    when state in ["ABI", "ENU", "OWE"] do
    "Eastern"
  end

  defp get_state_region(<<state::binary-size(3), _account::binary>>)
    when state in ["BAY", "DEL", "RIV"] do
    "Southern"
  end

  defp get_state_region(<<state::binary-size(3), _account::binary>>)
    when state in ["BOR", "KAT", "KAN"] do
    "Northern"
  end

  defp get_state_region(<<state::binary-size(3), _account::binary>>)
    when state in ["EDO", "LAG", "OYO"] do
    "Western"
  end
end
