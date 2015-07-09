defmodule Auth.Router do
  use Auth.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :org_api do
    plug :accepts, ["json"]
    plug Auth.Plugs.Org
  end

  scope "/", Auth do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", Auth.Api do
    pipe_through :api

    resources "/orgs", OrgController, only: [:show, :create]
  end

  scope "/api/:org", Auth.Api do
    pipe_through :org_api

    resources "/users", UserController, only: [
      :create, :show, :index, :delete]
  end
end
