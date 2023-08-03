defmodule App.UserReporter do
  def print_balance(%BalanceOutput{} = balance) do
    "#{balance.name} has #{balance.currency} #{balance.amount} balance in his account"
    |> IO.inspect()
  end

  def print_social_inference(%BalanceOutput{} = balance) do
    push_to_somewhere(balance)

    statement =
      case balance.amount do
        amnt when amnt > 200 -> "above poverty"
        _ -> "below poverty"
      end

    "#{balance.name} is living #{statement}"
    |> IO.inspect()
  end

  defp push_to_somewhere(%BalanceOutput{} = _balance) do
    # push to somewhere
    IO.inspect("PUSHING to somewhere")
  end
end
