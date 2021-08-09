defmodule TellerSandbox.TransactionsTest do
  use TellerSandbox.DataCase

  alias TellerSandbox.Transactions

  describe "list_transactions/2" do
    test "list_transactions/2 returns all transactions for an account" do
      transactions = Transactions.list_transactions("test_123456", "test_0YFbrC34zwYq3Jw")

      assert transactions |> Enum.slice(0..1) == [
               %{
                 account_id: "test_0YFbrC34zwYq3Jw",
                 amount: "-9.42",
                 date: "2021-01-01",
                 description: "Subway",
                 id: "test_8rAzPNUeu4Rz_3B",
                 links: %{
                   account: "http://localhost/accounts/test_0YFbrC34zwYq3Jw",
                   self:
                     "http://localhost/accounts/test_0YFbrC34zwYq3Jw/transactions/test_8rAzPNUeu4Rz_3B"
                 },
                 running_balance: "5000.00",
                 type: "card_payment"
               },
               %{
                 account_id: "test_0YFbrC34zwYq3Jw",
                 amount: "-1.13",
                 date: "2020-12-31",
                 description: "Apple",
                 id: "test_GExd2jZwX7D9_57",
                 links: %{
                   account: "http://localhost/accounts/test_0YFbrC34zwYq3Jw",
                   self:
                     "http://localhost/accounts/test_0YFbrC34zwYq3Jw/transactions/test_GExd2jZwX7D9_57"
                 },
                 running_balance: "5009.42",
                 type: "card_payment"
               }
             ]
    end
  end

  describe "get_transaction!/3" do
    test "it returns the transaction with the given id" do
      assert Transactions.get_transaction!(
               "test_123456",
               "test_0YFbrC34zwYq3Jw",
               "test_8rAzPNUeu4Rz_3B"
             ) == %{
               account_id: "test_0YFbrC34zwYq3Jw",
               amount: "-9.42",
               date: "2021-01-01",
               description: "Subway",
               id: "test_8rAzPNUeu4Rz_3B",
               links: %{
                 account: "http://localhost/accounts/test_0YFbrC34zwYq3Jw",
                 self:
                   "http://localhost/accounts/test_0YFbrC34zwYq3Jw/transactions/test_8rAzPNUeu4Rz_3B"
               },
               running_balance: "5000.00",
               type: "card_payment"
             }
    end
  end
end
