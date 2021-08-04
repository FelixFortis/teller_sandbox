defmodule TellerSandboxWeb.AccountController do
  use TellerSandboxWeb, :controller

  alias TellerSandbox.Accounts

  action_fallback TellerSandboxWeb.FallbackController

  def index(conn, _params) do
    accounts = Accounts.list_accounts()
    render(conn, "index.json", accounts: accounts)
  end

  def show(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)
    render(conn, "show.json", account: account)
  end
end
