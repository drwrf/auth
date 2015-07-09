defmodule Auth.Login do
  use Auth.Web, :model

  alias Auth.Org
  alias Auth.User

  schema "logins" do
    field :token, :string

    belongs_to :org, Org
    belongs_to :user, User

    timestamps
  end

  @required_fields ~w(org_id user_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> generate_token
  end

  def generate_token(changeset) do
    case get_field(changeset, :token) do
      nil -> put_change(changeset, :token, SecureRandom.uuid())
      ___ -> changeset
    end
  end
end
