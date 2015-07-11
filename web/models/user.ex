defmodule Auth.User do
  use Auth.Web, :model

  alias Comeonin.Bcrypt
  alias Auth.Org
  alias Auth.Repo

  schema "users" do
    field :username, :string
    field :email, :string
    field :password, :string
    field :is_deleted, :boolean

    belongs_to :org, Org

    timestamps
  end

  @required_fields ~w(org_id password)
  @optional_fields ~w(username email)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_identifier
    |> validate_unique(:email, on: Repo)
    |> validate_unique(:username, on: Repo)
    |> hash_password
  end

  @doc """
  Hashes an incoming password if one is passed in the changeset.
  """
  defp hash_password(changeset) do
    password = get_field(changeset, :password)

    if password do
      changeset = put_change(changeset, :password, Bcrypt.hashpwsalt(password))
    end

    changeset
  end

  @doc """
  Ensures that users specify either a username or an email in their payload.
  """
  defp validate_identifier(changeset) do
    # Users must specify either a username or an email
    if !get_field(changeset, :username) and !get_field(changeset, :email) do
      changeset = add_error(changeset, :username, 'username cannot be blank')
      changeset = add_error(changeset, :email, 'email cannot be blank')
    end

    changeset
  end
end
