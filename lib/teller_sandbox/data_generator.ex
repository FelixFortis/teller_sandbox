defmodule TellerSandbox.DataGenerator do
  @moduledoc """
  For generating pseudo-random data used in API responses.
  Uses a token to seed :rand so that the same results will come back if the same token is passed
  """

  @doc """
  Returns all of the random data as a list of maps.

  ## Examples

      iex> generate_accounts("test_token_123")
      [%Account{}, ...]

  """
  def generate_accounts(token) do
    :rand.seed(:exsplus, {100, 101, token_as_integer(token)})

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

  defp token_as_integer(token) do
    token
    |> String.to_charlist()
    |> IO.inspect(charlists: :as_list)
    |> Enum.join("")
    |> String.to_integer()
  end
end
