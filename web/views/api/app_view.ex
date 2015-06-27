defmodule Auth.Api.AppView do
  use Auth.Web, :view

  def render(name, %{app: app})
  when name in ["show.json", "create.json"] do
    %{
      id: app.slug,
      name: app.name,
      created_at: app.inserted_at,
      updated_at: app.updated_at,
    }
  end
end
