defmodule Auth.Api.LoginView do
  use Auth.Web, :view

  def render(name, %{login: login})
  when name in ["create.json"] do
    serialize login
  end

  def serialize(login) do
    %{
      id: login.token,
    }
  end
end
