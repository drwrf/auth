defmodule Auth.Api.LoginController do
  use Auth.Web, :controller

  alias Auth.User
  alias Auth.Login
  alias Comeonin.Bcrypt

  plug Auth.Plugs.Org
  plug :action

  def create(conn, params) do
    login = retrieve_user(conn, params)
         |> check_password(conn, params)
         |> to_login(conn, params)

    if login && login.valid? do
      login = Repo.insert!(login)

      conn
      |> put_status(201)
      |> render(login: login)
    else
      conn
      |> send_resp(400, '')
    end
  end

  defp retrieve_user(conn, params) do
    query = assoc(conn.assigns.org, :users)

    # For now we only allow logins on username OR email, never
    # both at the same time. This may be fine but it's better
    # to be sure first before we expose it.
    case params do
      %{"email"    => e} -> Repo.get_by(query, email: e)
      %{"username" => u} -> Repo.get_by(query, username: u)
      __________________ -> nil
    end
  end

  defp check_password(user, conn, params) do
    case User.valid_password?(user, params["password"]) do
      true  -> user
      false -> nil
    end
  end

  defp to_login(user, conn, params) do
    case user do
      nil -> nil
      ___ -> Login.changeset(%Login{}, %{
        "org_id" => conn.assigns.org.id,
        "user_id" => user.id,
      })
    end
  end
end
