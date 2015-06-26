defmodule Auth.UserController do
  use Auth.Web, :controller

  alias Auth.User

  plug :action

  def create(conn, params) do
    changeset = User.changeset(%User{}, params)

    if changeset.valid? do
      Repo.insert!(changeset)

      conn
      |> send_resp(201, '')
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
