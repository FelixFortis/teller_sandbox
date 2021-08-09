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

      %{
        account: generate_account(account_id),
        transactions:
          generate_transactions(90, [],
            account_id: account_id,
            running_balance: "5000.00",
            running_date: ~D[2021-01-01]
          )
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
      balances: %{
        available: "5000.00",
        ledger: "5000.00"
      },
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

  @spec generate_transactions(any, any, any) :: any
  def generate_transactions(n, transactions, opts \\ [])

  def generate_transactions(n, transactions, opts)
      when n > 0 do
    transaction_id = random_id(length: 15)
    transaction_amount = random_transaction_amount()

    transaction = %{
      type: "card_payment",
      running_balance: opts[:running_balance],
      links: %{
        self: "http://localhost/accounts/#{opts[:account_id]}/transactions/#{transaction_id}",
        account: "http://localhost/accounts/#{opts[:account_id]}"
      },
      id: transaction_id,
      description: random_merchant(),
      date: Date.to_iso8601(opts[:running_date]),
      amount: "-" <> transaction_amount,
      account_id: "#{opts[:account_id]}"
    }

    new_balance = calculate_new_balance(opts[:running_balance], transaction_amount)
    new_date = Date.add(opts[:running_date], -1)

    generate_transactions(n - 1, [transaction | transactions],
      account_id: opts[:account_id],
      running_balance: new_balance,
      running_date: new_date
    )
  end

  def generate_transactions(_n, transactions, _opts), do: transactions |> Enum.reverse()

  defp token_as_integer(token) do
    token
    |> :erlang.phash2()
  end

  defp random_transaction_amount do
    (:rand.uniform() * 10)
    |> Float.ceil(10)
    |> Float.to_string()
    |> String.slice(0..3)
  end

  def calculate_new_balance(balance, transaction_amount) do
    txn_amount = transaction_amount_to_integer(transaction_amount)
    current_balance = transaction_amount_to_integer(balance)

    (current_balance + txn_amount)
    |> integer_to_transaction_amount()
  end

  defp integer_to_transaction_amount(amount) do
    amount_as_string = Integer.to_string(amount)

    Regex.split(~r{\d\d\z}, amount_as_string, include_captures: true, trim: true)
    |> List.insert_at(1, ".")
    |> Enum.join("")
  end

  defp transaction_amount_to_integer(amount) do
    amount
    |> String.split(".", trim: true)
    |> Enum.join("")
    |> String.to_integer()
  end

  defp random_id(length: length) do
    "test_" <> random_string(length: length)
  end

  defp random_string(length: length) do
    characters =
      "12234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_"
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
