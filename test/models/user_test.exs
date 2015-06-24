defmodule Auth.UserTest do
  use Auth.ModelCase

  alias Auth.User

  test "changeset with no username or password" do
    changeset = User.changeset(%User{}, %{
      password: ''
    })

    refute changeset.valid?
  end
end
