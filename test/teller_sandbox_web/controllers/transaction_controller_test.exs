defmodule TellerSandboxWeb.TransactionControllerTest do
  use TellerSandboxWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
    {:ok, conn: put_req_header(conn, "authorization", "Basic dGVzdF8xMjM0NTY3Og==")}
  end

  describe "index" do
    test "lists all transactions for an account", %{conn: conn} do
      account_id = "test_s7alqokw0VKdblk"

      conn = get(conn, Routes.account_transaction_path(conn, :index, account_id))
      assert json_response(conn, 200)

      assert List.first(json_response(conn, 200)["data"]) == %{
               "account_id" => "test_s7alqokw0VKdblk",
               "amount" => "-2.92",
               "date" => "2021-01-01",
               "description" => "Saks Fifth Avenue",
               "id" => "test_j1JL22S6Lc9gcv5",
               "links" => %{
                 "account" => "http://localhost/accounts/test_s7alqokw0VKdblk",
                 "self" =>
                   "http://localhost/accounts/test_s7alqokw0VKdblk/transactions/test_j1JL22S6Lc9gcv5"
               },
               "running_balance" => "5000.00",
               "type" => "card_payment"
             }

      assert List.last(json_response(conn, 200)["data"]) == %{
               "account_id" => "test_s7alqokw0VKdblk",
               "amount" => "-5.28",
               "date" => "2020-10-04",
               "description" => "Papa John's",
               "id" => "test_eVR2DJGw7K9P7cH",
               "links" => %{
                 "account" => "http://localhost/accounts/test_s7alqokw0VKdblk",
                 "self" =>
                   "http://localhost/accounts/test_s7alqokw0VKdblk/transactions/test_eVR2DJGw7K9P7cH"
               },
               "running_balance" => "5474.95",
               "type" => "card_payment"
             }
    end
  end

  describe "show" do
    test "it returns the transaction by id", %{conn: conn} do
      account_id = "test_s7alqokw0VKdblk"
      transaction_id = "test_eVR2DJGw7K9P7cH"
      conn = get(conn, Routes.account_transaction_path(conn, :show, account_id, transaction_id))

      assert json_response(conn, 200)
    end
  end
end
