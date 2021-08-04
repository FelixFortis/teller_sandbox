defmodule TellerSandboxWeb.AccountView do
  use TellerSandboxWeb, :view
  alias TellerSandboxWeb.AccountView

  def render("index.json", %{accounts: accounts}) do
    %{data: render_many(accounts, AccountView, "account.json")}
  end

  def render("show.json", %{account: account}) do
    %{data: render_one(account, AccountView, "account.json")}
  end

  def render("account.json", %{account: account}) do
    %{
      id: account.id,
      account_number: account.account_number,
      balances: account.balances,
      currency_code: account.currency_code,
      enrollment_id: account.enrollment_id,
      institution: account.institution,
      links: account.links,
      name: account.name,
      routing_numbers: account.routing_numbers
    }
  end
end
