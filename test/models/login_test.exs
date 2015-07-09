defmodule Auth.LoginTest do
  use Auth.ModelCase

  alias Auth.Login

  @valid_attrs %{token: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Login.changeset(%Login{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Login.changeset(%Login{}, @invalid_attrs)
    refute changeset.valid?
  end
end
