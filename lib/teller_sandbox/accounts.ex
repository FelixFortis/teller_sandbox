defmodule TellerSandbox.Accounts do
  @moduledoc """
  The Accounts context.
  """

  @doc """
  Returns the list of accounts.

  ## Examples

      iex> list_accounts()
      [%Account{}, ...]

  """
  def list_accounts do
    raise "TODO"
  end

  @doc """
  Gets a single account.

  Raises if the Account does not exist.

  ## Examples

      iex> get_account!(123)
      %Account{}

  """
  def get_account!(id), do: raise("TODO")

  def create_account(token) do
    {:ok, %{account_number: "123"}}
  end
end
