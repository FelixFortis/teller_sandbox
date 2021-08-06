defmodule TellerSandbox.AccountsTest do
  use TellerSandbox.DataCase

  alias TellerSandbox.Accounts

  describe "list_accounts/1 " do
    test "it returns all accounts" do
      assert Accounts.list_accounts("test_1234567") == [
               %{
                 account_number: 367,
                 balances: %{available: "93.60", ledger: "93.60"},
                 currency_code: "USD",
                 enrollment_id: "test_-7YND7I9QZGpt2f",
                 id: "test_W56xjgDUFBFqjKZ",
                 institution: %{id: "wells_fargo", name: "Wells Fargo"},
                 links: %{
                   self: "http://localhost:4000/accounts/test_W56xjgDUFBFqjKZ",
                   transactions:
                     "http://localhost:4000/accounts/test_W56xjgDUFBFqjKZ/transactions"
                 },
                 name: "Test Checking Account",
                 routing_numbers: %{ach: "615933022", wire: "469420120"}
               },
               %{
                 account_number: 367,
                 balances: %{available: "80.11", ledger: "80.11"},
                 currency_code: "USD",
                 enrollment_id: "test_J20MZ2pjKyd_bTJ",
                 id: "test_rdt7AusLY2CTPG_",
                 institution: %{id: "capital_one", name: "Capital One"},
                 links: %{
                   self: "http://localhost:4000/accounts/test_rdt7AusLY2CTPG_",
                   transactions:
                     "http://localhost:4000/accounts/test_rdt7AusLY2CTPG_/transactions"
                 },
                 name: "Test Checking Account",
                 routing_numbers: %{ach: "176225235", wire: "354097347"}
               },
               %{
                 account_number: 367,
                 balances: %{available: "7.139", ledger: "7.139"},
                 currency_code: "USD",
                 enrollment_id: "test_XZSczG6P_KslBaX",
                 id: "test_5RCuUlRdc4-0PpB",
                 institution: %{id: "wells_fargo", name: "Wells Fargo"},
                 links: %{
                   self: "http://localhost:4000/accounts/test_5RCuUlRdc4-0PpB",
                   transactions:
                     "http://localhost:4000/accounts/test_5RCuUlRdc4-0PpB/transactions"
                 },
                 name: "Test Checking Account",
                 routing_numbers: %{ach: "951594080", wire: "294937012"}
               }
             ]
    end
  end
end
