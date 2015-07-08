defmodule Auth.Api.UserController do
  use Auth.Web, :controller

  alias Auth.User

  plug :action

  def create(conn, params) do
    changeset = User.changeset(%User{}, Map.merge(params, %{
      "org_id" => conn.assigns.org.id
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

  def show(conn, %{
    "id" => id,
    "org" => _,
    "format" => _
  }) do
    query = assoc(conn.assigns.org, :users)
    user = Repo.get_by(query, id: id)

    render conn, user: user
  end
end
