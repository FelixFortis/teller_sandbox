defmodule TellerSandbox.Transactions do
  @moduledoc """
  The Transactions context.
  """

  alias TellerSandbox.DataGeneration.DataGenerator

  @doc """
  Returns the list of transactions.

  ## Examples

      iex> list_transactions("test_token_123", "test_id_456")
      [%{}, ...]

  """
  def list_transactions(token, account_id) do
    DataGenerator.map_accounts_and_transactions(token)
    |> find_transactions_by_account_id(account_id)
  end

  @doc """
  Gets a single transaction.

  Raises if the Transaction does not exist.

  ## Examples

      iex> get_transaction!(123)
      %Transaction{}

  """
  def get_transaction!(token, account_id, id), do: raise("TODO")

  defp find_transactions_by_account_id(accounts_and_transactions, account_id) do
    accounts_and_transactions
    |> Enum.filter(fn account_and_transactions ->
      account_and_transactions.account.id == account_id
    end)
    |> List.first()
    |> Map.get(:transactions)
  end
end
