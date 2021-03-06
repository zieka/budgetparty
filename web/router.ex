defmodule Budgetparty.Router do
  use Budgetparty.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Budgetparty do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    get "/home", HomeController, :index

    resources "/wants", WantsController
    resources "/needs", NeedsController

    resources "/registration", RegistrationController, only: [:new, :create]

    get    "/login",  SessionController, :new
    post   "/login",  SessionController, :create
    delete "/logout", SessionController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", Budgetparty do
  #   pipe_through :api
  # end
end
