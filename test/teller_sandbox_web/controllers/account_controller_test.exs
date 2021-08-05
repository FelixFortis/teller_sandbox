defmodule TellerSandboxWeb.AccountControllerTest do
  use TellerSandboxWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index when a valid token is present" do
    setup %{conn: conn} do
      {:ok, conn: put_req_header(conn, "token", "test_123456")}
    end

    test "lists all accounts", %{conn: conn} do
      conn = get(conn, Routes.account_path(conn, :index))

      assert json_response(conn, 200)["data"] == [
               %{
                 "account_number" => 367,
                 "balances" => %{"available" => "1256.31", "ledger" => "1256.31"},
                 "currency_code" => "USD",
                 "enrollment_id" => "test_enr_1xyG_97e",
                 "id" => "test_acc_E6kuc45U",
                 "institution" => %{"id" => "teller_bank", "name" => "The Teller Bank"},
                 "links" => %{
                   "self" => "http://localhost/accounts/test_acc_E6kuc45U",
                   "transactions" => "http://localhost/accounts/test_acc_E6kuc45U/transactions"
                 },
                 "name" => "Test Checking Account",
                 "routing_numbers" => %{"ach" => "864952590", "wire" => "124952590"}
               }
             ]
    end
  end

  describe "index when an invalid token is present" do
    test "lists all accounts", %{conn: conn} do
      conn = get(conn, Routes.account_path(conn, :index))
      assert json_response(conn, 401)
    end
  end
end
