defmodule TellerSandbox.Plug.AuthenticateRequest do
  import Plug.Conn

  alias TellerSandbox.AuthToken

  def init(_params) do
  end

  def call(conn, _params) do
    case AuthToken.validate_token(conn) do
      {:ok, token} ->
        assign(conn, :token, token)

      {:error, _error} ->
        conn
        |> put_status(:unauthorized)
        |> Phoenix.Controller.render(TellerSandboxWeb.ErrorView, "401.json")
        |> halt
    end
  end
end
