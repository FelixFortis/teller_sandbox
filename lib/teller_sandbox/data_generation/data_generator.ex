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

      iex> map_accounts_and_transactions("test_token_123")
      [%{account: %{}, transactions: [%{}, ...]}, ...]

  """
  def map_accounts_and_transactions(token) do
    :rand.seed(:exsplus, {100, 101, token_as_integer(token)})

    number_of_accounts = Enum.random(1..3)

    Enum.map(1..number_of_accounts, fn _ ->
      account_id = random_id(length: 15)
      opening_balance = "5000.00"

      transaction_amount = %{
        account: generate_account(account_id),
        transactions: map_transactions(account_id)
      }
    end)
  end

  def map_accounts(token) do
    :rand.seed(:exsplus, {100, 101, token_as_integer(token)})

    number_of_accounts = Enum.random(1..3)

    Enum.map(1..number_of_accounts, fn _ ->
      account_id = random_id(length: 15)
      generate_account(account_id)
    end)
  end

  defp generate_account(account_id) do
    %{
      id: account_id,
      account_number: 367,
      balances: random_balance(),
      currency_code: "USD",
      enrollment_id: random_id(length: 15),
      institution: random_institution(),
      links: %{
        self: "http://localhost:4000/accounts/#{account_id}",
        transactions: "http://localhost:4000/accounts/#{account_id}/transactions"
      },
      name: "Test Checking Account",
      routing_numbers: %{
        ach: random_number_string(length: 9),
        wire: random_number_string(length: 9)
      }
    }
  end

  def map_transactions(account_id) do
    Enum.map(1..2, fn _ ->
      generate_transaction(account_id)
    end)
  end

  defp generate_transaction(account_id) do
    %{
      type: "card_payment",
      running_balance: "1250.00",
      links: %{
        self: "http://localhost/accounts/#{account_id}/transactions/test_txn_2f4Nf0Vz",
        account: "http://localhost/accounts/#{account_id}"
      },
      id: random_id(length: 15),
      description: random_merchant(),
      date: "2019-11-19",
      amount: "-6.31",
      account_id: "#{account_id}"
    }
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
