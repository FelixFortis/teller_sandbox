defmodule TellerSandboxWeb.AccountController do
  use TellerSandboxWeb, :controller

  alias TellerSandbox.Accounts

  action_fallback TellerSandboxWeb.FallbackController

  def index(conn, _params) do
    accounts = Accounts.list_accounts(conn.assigns.token)

    render(conn, "index.json", accounts: accounts)
  end

  def show(conn, %{"id" => id}) do
    account = Accounts.get_account!(id, conn.assigns.token)
    render(conn, "show.json", account: account)
  end
end
