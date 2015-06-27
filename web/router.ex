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

  pipeline :app_api do
    plug :accepts, ["json"]
    plug Auth.Plugs.App
  end

  scope "/", Auth do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", Auth.Api do
    pipe_through :api

    resources "/apps", AppController, only: [:show, :create]
  end

  scope "/api/:app", Auth.Api do
    pipe_through :app_api

    resources "/users", UserController, only: [:show, :create]
  end
end
