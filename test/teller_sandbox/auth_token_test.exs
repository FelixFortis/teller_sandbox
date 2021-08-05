defmodule TellerSandbox.AuthTokenTest do
  use TellerSandboxWeb.ConnCase

  alias TellerSandbox.AuthToken

  describe "#validate_token" do
    setup %{conn: conn} do
      {:ok, conn: put_req_header(conn, "token", "test_123456")}
    end

    test "returns the token if it exists and is valid" do
    end
  end
end
