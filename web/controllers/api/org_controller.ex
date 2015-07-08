defmodule Auth.Api.OrgController do
  use Auth.Web, :controller

  alias Auth.Org

  plug :action

  def create(conn, params) do
    changeset = Org.changeset(%Org{}, params)

    if changeset.valid? do
      org = Repo.insert!(changeset)

      conn
      |> put_status(201)
      |> render(org: org)
    else
      conn
      |> send_resp(400, '')
    end
  end

  def show(conn, %{"id" => id, "format" => _}) do
    render conn, org: Repo.get_by(Org, slug: id)
 end
end
