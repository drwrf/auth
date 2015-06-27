defmodule Auth.Plugs.App do
  import Plug.Conn

  alias Auth.App
  alias Auth.Repo

  def init(_), do: nil

  def call(conn, _) do
    case Repo.get_by(App, slug: conn.params["app"]) do
      nil -> conn |> send_resp(404, '') |> halt
      app -> conn |> assign(:app, app)
    end
  end
end
