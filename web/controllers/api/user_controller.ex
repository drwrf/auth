defmodule Auth.Api.UserController do
  use Auth.Web, :controller

  alias Auth.User
  alias Auth.App

  plug :action

  def create(conn, params) do
    changeset = User.changeset(%User{}, Map.merge(params, %{
      "app_id" => conn.assigns.app.id
    }))

    if changeset.valid? do
      user = Repo.insert!(changeset)

      conn
      |> put_status(201)
      |> render(user: user)
    else
      conn
      |> send_resp(400, '')
    end
  end

  def show(conn, %{"id" => id, "format" => format}) do
    user = Repo.get_by(User, id: id)
    render conn, user: user
  end
end
