defmodule Auth.Api.UserController do
  use Auth.Web, :controller

  alias Auth.User

  plug Auth.Plugs.Org
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

  def index(conn, params) do
    query = assoc(conn.assigns.org, :users)
    users = Repo.paginate(query, params)

    render conn, users: users
  end

  def show(conn, %{
    "id" => id,
    "org" => _,
    "format" => _
  }) do
    query = assoc(conn.assigns.org, :users)
    user = Repo.get_by!(query, id: id)

    render conn, user: user
  end

  def delete(conn, %{
    "id" => id,
    "org" => _,
    "format" => _
  }) do
    query = assoc(conn.assigns.org, :users)
    user = Repo.get_by!(query, id: id)
    user = %{user | is_deleted: true}
    Repo.update!(user)

    render conn, user: user
  end
end
