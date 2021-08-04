defmodule TellerSandbox.AccountsTest do
  use TellerSandbox.DataCase

  alias TellerSandbox.Accounts

  describe "accounts" do
    alias TellerSandbox.Accounts.Account

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def account_fixture(attrs \\ %{}) do
      {:ok, account} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_account()

      account
    end

    test "list_accounts/0 returns all accounts" do
      account = account_fixture()
      assert Accounts.list_accounts() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert Accounts.get_account!(account.account_number) == account
    end
  end
end
