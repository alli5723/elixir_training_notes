defmodule Demo.Workflows.TransferFx do
  @moduledoc """
  TransferFx is a workflow that transfers money between two accounts
  in different currencies.
  """
  defmodule Input do
    defstruct [:from, :to, :amount]
  end

  @doc """
    Runs the workflow.
      iex> response = Demo.Workflows.TransferFx.run(%Demo.Workflows.TransferFx.Input{from: "USD", to: "EUR", amount: 100})
      iex> is_atom(response)
      true
  """
  @spec run(Input.t()) :: :ok | {:error, String.t()}
  def run(%__MODULE__.Input{} = input) do
    IO.inspect("Transferring money between accounts in different currencies")
    :ok
  end
end
