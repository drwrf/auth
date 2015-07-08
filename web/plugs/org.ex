defmodule Auth.Plugs.Org do
  import Plug.Conn

  alias Auth.Org
  alias Auth.Repo

  def init(_), do: nil

  def call(conn, _) do
    case Repo.get_by(Org, slug: conn.params["org"]) do
      nil -> conn |> send_resp(404, '') |> halt
      org -> conn |> assign(:org, org)
    end
  end
end
