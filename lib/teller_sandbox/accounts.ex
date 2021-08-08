defmodule TellerSandbox.Accounts do
  @moduledoc """
  The Accounts context.
  """
  alias TellerSandbox.DataGeneration.DataGenerator

  @doc """
  Returns the list of accounts.

  ## Examples

      iex> list_accounts()
      [%Account{}, ...]

  """
  def list_accounts(token) do
    DataGenerator.map_accounts(token)
  end

  @doc """
  Gets a single account.

  Raises if the Account does not exist.

  ## Examples

      iex> get_account!(123)
      %Account{}

  """
  def get_account!(id, token) do
    DataGenerator.map_accounts(token)
    |> find_account_by_id(id)
  end

  defp find_account_by_id(accounts, id) do
    accounts
    |> Enum.filter(fn account -> account[:id] == id end)
    |> List.first()
  end
end
