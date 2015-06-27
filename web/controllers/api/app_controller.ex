defmodule Auth.Api.AppController do
  use Auth.Web, :controller

  alias Auth.App

  plug :action

  def create(conn, params) do
    changeset = App.changeset(%App{}, params)

    if changeset.valid? do
      app = Repo.insert!(changeset)

      conn
      |> put_status(201)
      |> render(app: app)
    else
      conn
      |> send_resp(400, '')
    end
  end

  def show(conn, %{"id" => id, "format" => format}) do
    app = Repo.get_by(App, slug: id)
    render conn, app: app
  end
end
