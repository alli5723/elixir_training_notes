defmodule App.BankStatements do
  @moduledoc """
  This module is responsible for generating bank statements for users
  It demonstrates
  - Pattern matching
  - Function composition
  - Capture Operator
  - Invoking anonymous functions
  """
  @users [
    %{
      name: "Fodio",
      amount: "200",
      country: :NG
    },
    %{
      name: "Silvia",
      amount: "230",
      country: :UK
    },
    %{
      name: "Bakare",
      amount: "130",
      country: :SE
    },
    %{
      name: "Maxwell",
      amount: "305",
      country: :CN
    }
  ]

  def run(user_id, printer) do
    case Enum.at(@users, user_id) do
      nil -> "The user #{user_id} specified does not exist"
      user ->
        printer.(BalanceOutput.new(user))
    end
  end
end

defmodule BalanceOutput do
  defstruct [:name, :amount, :currency]

  def new(balance) do
    %__MODULE__{
      name: balance.name,
      amount: balance.amount,
      currency: currency(balance)
    }
  end

  @typedoc """
  The user's balance map with the name, amount and country
  """
  @type user_balance :: %{
    name: String.t(),
    amount: String.t(),
    country: atom()
  }

  @spec currency(user_balance) :: String.t()
  def currency(%{country: :NG}), do: "NGN"

  def currency(%{country: :UK}), do: "£"

  def currency(%{country: :SE}), do: "€"

  def currency(%{country: :CN}), do: "YEN"

  def currency(_), do: "M"
end

# App.BankStatements.run(1, &App.UserReporter.print_balance/1)
# App.BankStatements.run(1, &App.UserReporter.print_social_inference/1)
