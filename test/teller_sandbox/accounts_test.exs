defmodule TellerSandbox.AccountsTest do
  use TellerSandbox.DataCase

  alias TellerSandbox.Accounts

  describe "accounts" do
    test "list_accounts/1 returns all accounts" do
      assert Accounts.list_accounts("test_123456") == [
               %{
                 account_number: 367,
                 balances: %{available: "1256.31", ledger: "1256.31"},
                 currency_code: "USD",
                 enrollment_id: "test_enr_1xyG_97e",
                 id: "test_acc_E6kuc45U",
                 institution: %{id: "teller_bank", name: "The Teller Bank"},
                 links: %{
                   self: "http://localhost/accounts/test_acc_E6kuc45U",
                   transactions: "http://localhost/accounts/test_acc_E6kuc45U/transactions"
                 },
                 name: "Test Checking Account",
                 routing_numbers: %{ach: "864952590", wire: "124952590"}
               }
             ]
    end
  end
end
