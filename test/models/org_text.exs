defmodule Auth.OrgTest do
  use Auth.ModelCase

  alias Auth.Org

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Org.changeset(%Org{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Org.changeset(%Org{}, @invalid_attrs)
    refute changeset.valid?
  end
end
