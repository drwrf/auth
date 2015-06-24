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

  def show(conn, _params) do
    json conn, %{
      id: 1,
      email: "hi@drwrf.com",
      username: "hi@drwrf.com",
      is_verified: true,
      is_deleted: false,
      is_recoverable: true,
      created_at: "2015-06-21T18:24:18+00:00",
      updated_at: "2015-06-21T18:24:18+00:00",
      last_login: nil,
    }
  end
end
