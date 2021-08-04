defmodule TellerSandboxWeb.AccountControllerTest do
  use TellerSandboxWeb.ConnCase

  alias TellerSandbox.Accounts
  alias TellerSandbox.Accounts.Account

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:account) do
    {:ok, account} = Accounts.create_account(@create_attrs)
    account
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all accounts", %{conn: conn} do
      conn = get(conn, Routes.account_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end
end
