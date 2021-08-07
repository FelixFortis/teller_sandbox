defmodule TellerSandboxWeb.TransactionControllerTest do
  use TellerSandboxWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
    {:ok, conn: put_req_header(conn, "token", "test_1234567")}
  end

  describe "index" do
    test "lists all transactions for an account", %{conn: conn} do
      account_id = "test_W56xjgDUFBFqjKZ"

      conn = get(conn, Routes.account_transaction_path(conn, :index, account_id))
      assert json_response(conn, 200)["data"] == []
    end
  end
end
