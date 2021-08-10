defmodule TellerSandboxWeb.AccountController do
  use TellerSandboxWeb, :controller

  alias TellerSandbox.Accounts

  def index(conn, _params) do
    accounts = Accounts.list_accounts(conn.assigns.auth_token)

    render(conn, "index.json", accounts: accounts)
  end

  def show(conn, %{"id" => id}) do
    account = Accounts.get_account!(conn.assigns.auth_token, id)

    cond do
      is_nil(account) ->
        conn
        |> put_status(:not_found)
        |> put_view(TellerSandboxWeb.ErrorView)
        |> render(:"404")

      is_map(account) ->
        render(conn, "show.json", account: account)
    end
  end
end
