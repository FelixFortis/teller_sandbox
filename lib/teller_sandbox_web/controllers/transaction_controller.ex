defmodule TellerSandboxWeb.TransactionController do
  use TellerSandboxWeb, :controller

  alias TellerSandbox.Transactions

  def index(conn, %{"account_id" => account_id}) do
    transactions = Transactions.list_transactions(conn.assigns.token, account_id)
    render(conn, "index.json", transactions: transactions)
  end

  def show(conn, %{"account_id" => account_id, "id" => id}) do
    transaction = Transactions.get_transaction!(conn.assigns.token, account_id, id)
    render(conn, "show.json", transaction: transaction)
  end
end
