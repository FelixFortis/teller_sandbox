defmodule TellerSandboxWeb.TransactionController do
  use TellerSandboxWeb, :controller

  alias TellerSandbox.Transactions
  alias TellerSandbox.Transactions.Transaction

  def index(conn, _params) do
    transactions = Transactions.list_transactions()
    render(conn, "index.json", transactions: transactions)
  end

  def show(conn, %{"id" => id}) do
    transaction = Transactions.get_transaction!(id)
    render(conn, "show.json", transaction: transaction)
  end
end
