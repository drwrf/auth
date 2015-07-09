defmodule Auth.Api.LoginController do
  use Auth.Web, :controller

  alias Auth.User
  alias Auth.Login
  alias Comeonin.Bcrypt

  plug Auth.Plugs.Org
  plug :action

  def create(conn, params) do
    user = retrieve_user(conn, params)
    login = create_login(conn, user)

    conn
    |> check_password(user, params)
    |> persist_login(login, params)
  end

  defp retrieve_user(conn, params) do
    query = assoc(conn.assigns.org, :users)

    # For now we only allow logins on username OR email, never
    # both at the same time. This may be fine but it's better
    # to be sure first before we expose it.
    user = case params do
      %{"email"    => e} -> Repo.get_by(query, email: e)
      %{"username" => u} -> Repo.get_by(query, username: u)
      __________________ -> nil
    end
  end

  defp create_login(conn, user) do
    case user do
      nil -> nil
      ___ -> Login.changeset(%Login{}, %{
        "org_id" => conn.assigns.org.id,
        "user_id" => user.id,
      })
    end
  end

  defp check_password(conn, user, params) do
    valid = case [user, params["password"]] do
      [%User{}, pw] when is_binary(pw) ->
        Bcrypt.checkpw(pw, user.password)
      _ ->
        Bcrypt.dummy_checkpw
    end

    case valid do
      false -> conn |> send_resp(400, '') |> halt
      true  -> conn
    end
  end

  def persist_login(conn, login, params) do
    if login.valid? do
      login = Repo.insert!(login)

      conn
      |> put_status(201)
      |> render(login: login)
    else
      conn
      |> send_resp(400, '')
    end
  end
end
