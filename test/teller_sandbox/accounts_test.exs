defmodule TellerSandbox.AccountsTest do
  use TellerSandbox.DataCase

  alias TellerSandbox.Accounts

  describe "get_account!/2" do
    test "it returns an account by id" do
      assert Accounts.get_account!("test_1234567", "test_Ktj_AZwhsNpUd4l") ==
               %{
                 account_number: 367,
                 balances: %{available: "5000.00", ledger: "5000.00"},
                 currency_code: "USD",
                 enrollment_id: "test_L0QQhl6Lno5MktR",
                 id: "test_Ktj_AZwhsNpUd4l",
                 institution: %{id: "chase", name: "Chase"},
                 links: %{
                   self: "http://localhost:4000/accounts/test_Ktj_AZwhsNpUd4l",
                   transactions:
                     "http://localhost:4000/accounts/test_Ktj_AZwhsNpUd4l/transactions"
                 },
                 name: "Test Checking Account",
                 routing_numbers: %{ach: "594080912", wire: "937012951"}
               }
    end
  end
end
