defmodule TellerSandbox.Authorization.AuthTokenTest do
  use TellerSandboxWeb.ConnCase

  alias TellerSandbox.Authorization.AuthToken

  describe "#validate_token" do
    setup %{conn: conn} do
      {:ok, conn: put_req_header(conn, "token", "test_123456")}
    end

    test "returns the token if it exists and is valid", %{conn: conn} do
      assert AuthToken.validate_token(conn) == {:ok, "test_123456"}
    end
  end
end
