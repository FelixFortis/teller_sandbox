defmodule TellerSandbox.DataGeneration.DataGenerator do
  @moduledoc """
  For generating pseudo-random data used in API responses.
  Uses a token to seed :rand so that the same results will come back if the same token is passed
  """
  @institutions Application.get_env(:teller_sandbox, :institutions)
  @merchants Application.get_env(:teller_sandbox, :merchants)
  @doc """
  Returns all of the random data as a list of maps.

  ## Examples

      iex> generate_accounts_and_transactions("test_token_123")
      [%{account: %{}, transactions: [%{}, ...]}, ...]

  """
  def generate_accounts_and_transactions(token) do
    :rand.seed(:exsplus, {100, 101, token_as_integer(token)})

    number_of_accounts = Enum.random(1..3)

    Enum.map(1..number_of_accounts, fn _ ->
      %{
        account: generate_account(),
        transactions: generate_transactions()
      }
    end)
  end

  def generate_accounts(token) do
    :rand.seed(:exsplus, {100, 101, token_as_integer(token)})

    number_of_accounts = Enum.random(1..3)

    Enum.map(1..number_of_accounts, fn _ -> generate_account() end)
  end

  defp generate_account do
    id = random_id(length: 15)

    %{
      id: id,
      account_number: 367,
      balances: random_balance(),
      currency_code: "USD",
      enrollment_id: random_id(length: 15),
      institution: random_institution(),
      links: %{
        self: "http://localhost:4000/accounts/#{id}",
        transactions: "http://localhost:4000/accounts/#{id}/transactions"
      },
      name: "Test Checking Account",
      routing_numbers: %{
        ach: random_number_string(length: 9),
        wire: random_number_string(length: 9)
      }
    }
  end

  defp generate_transactions() do
    [
      %{id: 1, type: "card_payment"},
      %{id: 2, type: "card_payment"}
    ]
  end

  defp token_as_integer(token) do
    token
    |> :erlang.phash2()
  end

  defp random_balance do
    balance =
      (:rand.uniform() * 100)
      |> Float.ceil(10)
      |> Float.to_string()
      |> String.slice(0..4)

    %{available: balance, ledger: balance}
  end

  defp random_id(length: length) do
    "test_" <> random_string(length: length)
  end

  defp random_string(length: length) do
    characters =
      "12234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_-"
      |> String.split("", trim: true)

    range = 1..length

    range
    |> Enum.reduce([], fn _, accumulator -> [Enum.random(characters) | accumulator] end)
    |> Enum.join("")
  end

  defp random_number_string(length: length) do
    numbers =
      "12234567890"
      |> String.split("", trim: true)

    range = 1..length

    range
    |> Enum.reduce([], fn _, accumulator -> [Enum.random(numbers) | accumulator] end)
    |> Enum.join("")
  end

  defp random_institution do
    institution_name = Enum.random(@institutions)

    institution_id =
      institution_name
      |> String.downcase()
      |> String.replace(" ", "_")

    %{id: institution_id, name: institution_name}
  end

  defp random_merchant do
    Enum.random(@merchants)
  end
end
