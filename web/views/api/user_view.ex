defmodule Auth.Api.UserView do
  use Auth.Web, :view

  def render(name, %{user: user})
  when name in ["show.json", "create.json", "delete.json"] do
    output user
  end

  def render(name, %{users: users})
  when name in ["index.json"] do
    %{
      users: (for user <- users.entries, do: output(user)),
      meta: %{
        page: users.page_number,
        page_size: users.page_size,
        total_pages: users.total_pages,
        total_entries: users.total_entries
      }
    }
  end

  def output(user) do
    %{
      id: user.id,
      username: user.username,
      email: user.email,
      is_deleted: user.is_deleted,
      created_at: user.inserted_at,
      updated_at: user.updated_at,
    }
  end
end
