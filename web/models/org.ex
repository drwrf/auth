defmodule Auth.Org do
  use Auth.Web, :model

  alias Auth.Repo
  alias Auth.User

  schema "orgs" do
    field :name, :string
    field :slug, :string

    has_many :users, User

    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> generate_slug
    |> validate_unique(:slug, on: Repo)
  end

  @doc """
  Generates a slug for the org record, so that users can refer
  to their org by a pretty identifier, as opposed to some sort
  of hard to read integer.
  """
  def generate_slug(changeset) do
    slug = get_field(changeset, :slug)

    if is_nil(slug) do
      slug = Slugger.slugify_downcase(get_field(changeset, :name, ""))
      changeset = put_change(changeset, :slug, slug)
    end

    if Repo.get_by(__MODULE__, slug: slug) do
      addition = SecureRandom.uuid() |> String.slice(0..2)
      changeset = put_change(changeset, :slug, slug <> "-" <> addition)
      changeset = generate_slug(changeset)
    end

    changeset
  end
end
