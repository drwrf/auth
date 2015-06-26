defmodule Auth.User do
  use Auth.Web, :model

  alias Comeonin.Bcrypt

  schema "users" do
    field :username, :string
    field :email, :string
    field :password, :string

    timestamps
  end

  @required_fields ~w()
  @optional_fields ~w(username email password)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> hash_password
    |> validate_username_or_email
  end

  @doc """
  Hashes an incoming password if one is passed in the changeset.
  """
  def hash_password(changeset) do
    password = get_field(changeset, :password)

    if password do
      changeset = put_change(changeset, :password, Bcrypt.hashpwsalt(password))
    end

    changeset
  end

  @doc """
  Ensures that users specify either a username or an email in their payload.
  """
  def validate_username_or_email(changeset) do
    # Users must specify either a username or an email
    if !get_field(changeset, :username) and !get_field(changeset, :email) do
      changeset = add_error(changeset, :username, 'username cannot be blank')
      changeset = add_error(changeset, :email, 'email cannot be blank')
    end

    changeset
  end
end
