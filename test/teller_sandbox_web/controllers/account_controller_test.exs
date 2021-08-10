defmodule TellerSandboxWeb.AccountControllerTest do
  use TellerSandboxWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index action when a valid token is present" do
    setup %{conn: conn} do
      {:ok, conn: put_req_header(conn, "authorization", "Basic dGVzdF8xMjM0NTY3Og==")}
    end

    test "lists all accounts", %{conn: conn} do
      conn = get(conn, Routes.account_path(conn, :index))

      assert json_response(conn, 200)["data"] == [
               %{
                 "account_number" => 367,
                 "balances" => %{"available" => "5000.00", "ledger" => "5000.00"},
                 "currency_code" => "USD",
                 "enrollment_id" => "test_UxzZf53obP68ZUX",
                 "id" => "test_s7alqokw0VKdblk",
                 "institution" => %{"id" => "capital_one", "name" => "Capital One"},
                 "links" => %{
                   "self" => "http://localhost:4000/accounts/test_s7alqokw0VKdblk",
                   "transactions" =>
                     "http://localhost:4000/accounts/test_s7alqokw0VKdblk/transactions"
                 },
                 "name" => "Test Checking Account",
                 "routing_numbers" => %{"ach" => "159330220", "wire" => "694201206"}
               },
               %{
                 "account_number" => 367,
                 "balances" => %{"available" => "5000.00", "ledger" => "5000.00"},
                 "currency_code" => "USD",
                 "enrollment_id" => "test_IMbKy6fvRjULUM_",
                 "id" => "test_j1JL22S6Lc9gcv5",
                 "institution" => %{"id" => "wells_fargo", "name" => "Wells Fargo"},
                 "links" => %{
                   "self" => "http://localhost:4000/accounts/test_j1JL22S6Lc9gcv5",
                   "transactions" =>
                     "http://localhost:4000/accounts/test_j1JL22S6Lc9gcv5/transactions"
                 },
                 "name" => "Test Checking Account",
                 "routing_numbers" => %{"ach" => "622523572", "wire" => "409734717"}
               },
               %{
                 "account_number" => 367,
                 "balances" => %{"available" => "5000.00", "ledger" => "5000.00"},
                 "currency_code" => "USD",
                 "enrollment_id" => "test_L0QQhl6Lno5MktR",
                 "id" => "test_Ktj_AZwhsNpUd4l",
                 "institution" => %{"id" => "chase", "name" => "Chase"},
                 "links" => %{
                   "self" => "http://localhost:4000/accounts/test_Ktj_AZwhsNpUd4l",
                   "transactions" =>
                     "http://localhost:4000/accounts/test_Ktj_AZwhsNpUd4l/transactions"
                 },
                 "name" => "Test Checking Account",
                 "routing_numbers" => %{"ach" => "594080912", "wire" => "937012951"}
               }
             ]
    end
  end

  describe "index action when an invalid token is present" do
    setup %{conn: conn} do
      {:ok, conn: put_req_header(conn, "authorization", "Basic dGVzdHpfMTIzNDU2Og==")}
    end

    test "401 unauthorized", %{conn: conn} do
      conn = get(conn, Routes.account_path(conn, :index))

      assert json_response(conn, 401)
    end
  end

  describe "index action when no token is present" do
    test "401 unauthorized", %{conn: conn} do
      conn = get(conn, Routes.account_path(conn, :index))

      assert json_response(conn, 401)
    end
  end

  describe "show action when a valid token is present and an account with the passed in id exists" do
    setup %{conn: conn} do
      {:ok, conn: put_req_header(conn, "authorization", "Basic dGVzdF8xMjM0NTY3Og==")}
    end

    test "returns the requested account", %{conn: conn} do
      id = "test_Ktj_AZwhsNpUd4l"
      conn = get(conn, Routes.account_path(conn, :show, id))

      assert json_response(conn, 200)["data"] ==
               %{
                 "account_number" => 367,
                 "balances" => %{"available" => "5000.00", "ledger" => "5000.00"},
                 "currency_code" => "USD",
                 "enrollment_id" => "test_L0QQhl6Lno5MktR",
                 "id" => "test_Ktj_AZwhsNpUd4l",
                 "institution" => %{"id" => "chase", "name" => "Chase"},
                 "links" => %{
                   "self" => "http://localhost:4000/accounts/test_Ktj_AZwhsNpUd4l",
                   "transactions" =>
                     "http://localhost:4000/accounts/test_Ktj_AZwhsNpUd4l/transactions"
                 },
                 "name" => "Test Checking Account",
                 "routing_numbers" => %{"ach" => "594080912", "wire" => "937012951"}
               }
    end
  end

  describe "show action when a valid token is present but an account with the passed in id doesn't exist" do
    setup %{conn: conn} do
      {:ok, conn: put_req_header(conn, "authorization", "Basic dGVzdF8xMjM0NTY3Og==")}
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
