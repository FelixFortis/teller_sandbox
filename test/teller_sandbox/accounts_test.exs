defmodule TellerSandbox.AccountsTest do
  use TellerSandbox.DataCase

  alias TellerSandbox.Accounts

  describe "get_account!/2" do
    test "it returns an account by id" do
      assert Accounts.get_account!("test_W56xjgDUFBFqjKZ", "test_1234567") ==
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
               }
    end
  end
end
