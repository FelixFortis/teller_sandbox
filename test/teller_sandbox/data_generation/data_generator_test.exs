defmodule TellerSandbox.DataGeneration.DataGeneratorTest do
  use TellerSandbox.DataCase

  alias TellerSandbox.DataGeneration.DataGenerator

  describe "#map_accounts/1" do
    test "returns a pseudorandom collection of accounts" do
      assert DataGenerator.map_accounts("test_1234567") == [
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

  describe "#map_accounts_and_transactions/1" do
    test "returns a pseudorandom collection of accounts and transactions" do
      assert DataGenerator.map_accounts_and_transactions("test_123456") == [
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
