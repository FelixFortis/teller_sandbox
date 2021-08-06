defmodule TellerSandbox.Plug.AuthenticateRequest do
  import Plug.Conn
  import Phoenix.Controller

  alias TellerSandbox.Authorization.AuthToken

  def init(_params) do
  end

  def call(conn, _params) do
    case AuthToken.validate_token(conn) do
      {:ok, token} ->
        assign(conn, :token, token)

      {:error, _error} ->
        conn
        |> put_status(:unauthorized)
        |> put_view(TellerSandboxWeb.ErrorView)
        |> render("401.json")
        |> halt
    end
  end
end
