defmodule TellerSandboxWeb.AccountControllerTest do
  use TellerSandboxWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index action when a valid token is present" do
    setup %{conn: conn} do
      {:ok, conn: put_req_header(conn, "token", "test_1234567")}
    end

    test "lists all accounts", %{conn: conn} do
      conn = get(conn, Routes.account_path(conn, :index))

      assert json_response(conn, 200)["data"] == [
               %{
                 "account_number" => 367,
                 "balances" => %{"available" => "93.60", "ledger" => "93.60"},
                 "currency_code" => "USD",
                 "enrollment_id" => "test_-7YND7I9QZGpt2f",
                 "id" => "test_W56xjgDUFBFqjKZ",
                 "institution" => %{"id" => "wells_fargo", "name" => "Wells Fargo"},
                 "links" => %{
                   "self" => "http://localhost:4000/accounts/test_W56xjgDUFBFqjKZ",
                   "transactions" =>
                     "http://localhost:4000/accounts/test_W56xjgDUFBFqjKZ/transactions"
                 },
                 "name" => "Test Checking Account",
                 "routing_numbers" => %{"ach" => "615933022", "wire" => "469420120"}
               },
               %{
                 "account_number" => 367,
                 "balances" => %{"available" => "80.11", "ledger" => "80.11"},
                 "currency_code" => "USD",
                 "enrollment_id" => "test_J20MZ2pjKyd_bTJ",
                 "id" => "test_rdt7AusLY2CTPG_",
                 "institution" => %{"id" => "capital_one", "name" => "Capital One"},
                 "links" => %{
                   "self" => "http://localhost:4000/accounts/test_rdt7AusLY2CTPG_",
                   "transactions" =>
                     "http://localhost:4000/accounts/test_rdt7AusLY2CTPG_/transactions"
                 },
                 "name" => "Test Checking Account",
                 "routing_numbers" => %{"ach" => "176225235", "wire" => "354097347"}
               },
               %{
                 "account_number" => 367,
                 "balances" => %{"available" => "7.139", "ledger" => "7.139"},
                 "currency_code" => "USD",
                 "enrollment_id" => "test_XZSczG6P_KslBaX",
                 "id" => "test_5RCuUlRdc4-0PpB",
                 "institution" => %{"id" => "wells_fargo", "name" => "Wells Fargo"},
                 "links" => %{
                   "self" => "http://localhost:4000/accounts/test_5RCuUlRdc4-0PpB",
                   "transactions" =>
                     "http://localhost:4000/accounts/test_5RCuUlRdc4-0PpB/transactions"
                 },
                 "name" => "Test Checking Account",
                 "routing_numbers" => %{"ach" => "951594080", "wire" => "294937012"}
               }
             ]
    end
  end

  describe "index action when an invalid token is present" do
    test "401 unauthorized", %{conn: conn} do
      conn = get(conn, Routes.account_path(conn, :index))

      assert json_response(conn, 401)
    end
  end

  describe "show action when a valid token is present and an account with the passed in id exists" do
    setup %{conn: conn} do
      {:ok, conn: put_req_header(conn, "token", "test_1234567")}
    end

    test "returns the requested account", %{conn: conn} do
      id = "test_5RCuUlRdc4-0PpB"
      conn = get(conn, Routes.account_path(conn, :show, id))

      assert json_response(conn, 200)["data"] ==
               %{
                 "account_number" => 367,
                 "balances" => %{"available" => "7.139", "ledger" => "7.139"},
                 "currency_code" => "USD",
                 "enrollment_id" => "test_XZSczG6P_KslBaX",
                 "id" => "test_5RCuUlRdc4-0PpB",
                 "institution" => %{"id" => "wells_fargo", "name" => "Wells Fargo"},
                 "links" => %{
                   "self" => "http://localhost:4000/accounts/test_5RCuUlRdc4-0PpB",
                   "transactions" =>
                     "http://localhost:4000/accounts/test_5RCuUlRdc4-0PpB/transactions"
                 },
                 "name" => "Test Checking Account",
                 "routing_numbers" => %{"ach" => "951594080", "wire" => "294937012"}
               }
    end
  end

  describe "show action when a valid token is present but an account with the passed in id doesn't exist" do
    setup %{conn: conn} do
      {:ok, conn: put_req_header(conn, "token", "test_1234567")}
    end

    test "returns the requested account", %{conn: conn} do
      id = "test_non_existent"
      conn = get(conn, Routes.account_path(conn, :show, id))

      assert json_response(conn, 404)
    end
  end

  describe "show action when an invalid token is present" do
    test "401 unauthorized", %{conn: conn} do
      id = "test_5RCuUlRdc4-0PpB"
      conn = get(conn, Routes.account_path(conn, :show, id))

      assert json_response(conn, 401)
    end
  end
end
