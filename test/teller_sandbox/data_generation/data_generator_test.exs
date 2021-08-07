defmodule TellerSandbox.DataGeneration.DataGeneratorTest do
  use TellerSandbox.DataCase

  alias TellerSandbox.DataGeneration.DataGenerator

  describe "#generate_accounts_and_transactions/1" do
    test "returns a pseudorandom collection of accounts and transactions" do
      assert DataGenerator.generate_accounts_and_transactions("test_123456") == [
               %{
                 account: %{
                   account_number: 367,
                   balances: %{
                     available: "30.00",
                     ledger: "30.00"
                   },
                   currency_code: "USD",
                   enrollment_id: "test_UFIpSkQ5wjRNdjc",
                   id: "test_p6b8n950gtxsqjv",
                   institution: %{
                     id: "chase",
                     name: "Chase"
                   },
                   links: %{
                     self: "http://localhost:4000/accounts/test_p6b8n950gtxsqjv",
                     transactions:
                       "http://localhost:4000/accounts/test_p6b8n950gtxsqjv/transactions"
                   },
                   name: "Test Checking Account",
                   routing_numbers: %{
                     ach: "744795987",
                     wire: "748901917"
                   }
                 },
                 transactions: [
                   %{id: 1, type: "card_payment"},
                   %{id: 2, type: "card_payment"}
                 ]
               }
             ]
    end
  end
end
