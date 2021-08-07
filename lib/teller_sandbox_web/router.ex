defmodule TellerSandboxWeb.Router do
  use TellerSandboxWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {TellerSandboxWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug TellerSandbox.Plug.AuthenticateRequest
  end

  scope "/", TellerSandboxWeb do
    pipe_through :browser

    live "/", PageLive, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", TellerSandboxWeb do
    pipe_through :api

    resources "/accounts", AccountController, only: [:index, :show] do
      resources "/transactions", TransactionController, only: [:index, :show]
    end
  end
end
