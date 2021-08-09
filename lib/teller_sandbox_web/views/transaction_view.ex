defmodule TellerSandboxWeb.TransactionView do
  use TellerSandboxWeb, :view
  alias TellerSandboxWeb.TransactionView

  def render("index.json", %{transactions: transactions}) do
    %{data: render_many(transactions, TransactionView, "transaction.json")}
  end

  def render("show.json", %{transaction: transaction}) do
    %{data: render_one(transaction, TransactionView, "transaction.json")}
  end

  def render("transaction.json", %{transaction: transaction}) do
    %{
      id: transaction.id,
      type: "card_payment",
      running_balance: transaction.running_balance,
      links: transaction.links,
      description: transaction.description,
      date: transaction.date,
      amount: transaction.amount,
      account_id: transaction.account_id
    }
  end
end
