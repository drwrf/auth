defmodule Auth.UserView do
  use Auth.Web, :view

  def render(name, %{user: user})
  when name in ["show.json", "create.json"] do
    %{
      id: user.id,
      username: user.username,
      email: user.email,
      created_at: user.inserted_at,
      updated_at: user.updated_at,
    }
  end
end
