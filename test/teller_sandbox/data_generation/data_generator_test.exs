defmodule TellerSandbox.DataGeneration.DataGeneratorTest do
  use TellerSandbox.DataCase

  alias TellerSandbox.DataGeneration.DataGenerator

  describe "#map_accounts/1" do
    test "returns a pseudorandom collection of accounts" do
      assert DataGenerator.map_accounts("test_1234567") == [
               %{
                 account_number: 367,
                 balances: %{available: "5000.00", ledger: "5000.00"},
                 currency_code: "USD",
                 enrollment_id: "test_UxzZf53obP68ZUX",
                 id: "test_s7alqokw0VKdblk",
                 institution: %{id: "capital_one", name: "Capital One"},
                 links: %{
                   self: "http://localhost:4000/accounts/test_s7alqokw0VKdblk",
                   transactions:
                     "http://localhost:4000/accounts/test_s7alqokw0VKdblk/transactions"
                 },
                 name: "Test Checking Account",
                 routing_numbers: %{ach: "159330220", wire: "694201206"}
               },
               %{
                 account_number: 367,
                 balances: %{available: "5000.00", ledger: "5000.00"},
                 currency_code: "USD",
                 enrollment_id: "test_IMbKy6fvRjULUM_",
                 id: "test_j1JL22S6Lc9gcv5",
                 institution: %{id: "wells_fargo", name: "Wells Fargo"},
                 links: %{
                   self: "http://localhost:4000/accounts/test_j1JL22S6Lc9gcv5",
                   transactions:
                     "http://localhost:4000/accounts/test_j1JL22S6Lc9gcv5/transactions"
                 },
                 name: "Test Checking Account",
                 routing_numbers: %{ach: "622523572", wire: "409734717"}
               },
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
             ]
    end
  end

  describe "#map_accounts_and_transactions/1" do
    test "returns a pseudorandom collection of accounts and transactions" do
      accounts_and_transactions =
        List.first(DataGenerator.map_accounts_and_transactions("test_123456"))

      assert Enum.count(accounts_and_transactions.transactions) == 90

      assert List.first(accounts_and_transactions.transactions) == %{
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

      assert List.last(accounts_and_transactions.transactions) == %{
               account_id: "test_0YFbrC34zwYq3Jw",
               amount: "-9.74",
               date: "2020-10-04",
               description: "Macy's",
               id: "test_76j9KbMFQdeVcrZ",
               links: %{
                 account: "http://localhost/accounts/test_0YFbrC34zwYq3Jw",
                 self:
                   "http://localhost/accounts/test_0YFbrC34zwYq3Jw/transactions/test_76j9KbMFQdeVcrZ"
               },
               running_balance: "5440.78",
               type: "card_payment"
             }
    end
  end

  describe "generate_transactions/3" do
    test "it returns a list of transactions" do
      :rand.seed(:exsplus, {100, 101, 102})

      assert DataGenerator.generate_transactions(3, [],
               account_id: 123,
               running_balance: "5000.00",
               running_date: ~D[2021-01-01]
             ) == [
               %{
                 account_id: "123",
                 amount: "-8.68",
                 date: "2021-01-01",
                 description: "Caltrain",
                 id: "test_zFy9AQjzuLXKURZ",
                 links: %{
                   account: "http://localhost/accounts/123",
                   self: "http://localhost/accounts/123/transactions/test_zFy9AQjzuLXKURZ"
                 },
                 running_balance: "5000.00",
                 type: "card_payment"
               },
               %{
                 account_id: "123",
                 amount: "-6.20",
                 date: "2020-12-31",
                 description: "iTunes",
                 id: "test_rmDkfBhL__pcCWP",
                 links: %{
                   account: "http://localhost/accounts/123",
                   self: "http://localhost/accounts/123/transactions/test_rmDkfBhL__pcCWP"
                 },
                 running_balance: "5008.68",
                 type: "card_payment"
               },
               %{
                 account_id: "123",
                 amount: "-3.34",
                 date: "2020-12-30",
                 description: "Panera",
                 id: "test_8l1LBqzwgWz4j12",
                 links: %{
                   account: "http://localhost/accounts/123",
                   self: "http://localhost/accounts/123/transactions/test_8l1LBqzwgWz4j12"
                 },
                 running_balance: "5014.88",
                 type: "card_payment"
               }
             ]
    end
  end
end
