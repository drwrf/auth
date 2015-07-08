defmodule Auth.Api.OrgView do
  use Auth.Web, :view

  def render(name, %{org: org})
  when name in ["show.json", "create.json"] do
    %{
      id: org.slug,
      name: org.name,
      created_at: org.inserted_at,
      updated_at: org.updated_at,
    }
  end
end
