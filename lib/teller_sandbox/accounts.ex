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
    generate_accounts
  end

  @doc """
  Gets a single account.

  Raises if the Account does not exist.

  ## Examples

      iex> get_account!(123)
      %Account{}

  """
  def get_account!(id), do: raise("TODO")

  def generate_accounts do
    [
      %{
        account_number: 367,
        balances: %{available: "1256.31", ledger: "1256.31"},
        currency_code: "USD",
        enrollment_id: "test_enr_1xyG_97e",
        institution: %{id: "teller_bank", name: "The Teller Bank"},
        links: %{
          self: "http://localhost/accounts/test_acc_E6kuc45U",
          transactions: "http://localhost/accounts/test_acc_E6kuc45U/transactions"
        },
        name: "Test Checking Account",
        routing_numbers: %{ach: "864952590", wire: "124952590"},
        id: "test_acc_E6kuc45U"
      }
    ]
  end
end
