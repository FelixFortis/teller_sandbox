defmodule TellerSandbox.Accounts do
  @moduledoc """
  The Accounts context.
  """
  alias TellerSandbox.DataGenerator

  @doc """
  Returns the list of accounts.

  ## Examples

      iex> list_accounts()
      [%Account{}, ...]

  """
  def list_accounts(token) do
    DataGenerator.generate_accounts(token)
  end

  @doc """
  Gets a single account.

  Raises if the Account does not exist.

  ## Examples

      iex> get_account!(123)
      %Account{}

  """
  def get_account!(id), do: raise("TODO")
end
