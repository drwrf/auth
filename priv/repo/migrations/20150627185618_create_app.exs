defmodule Auth.Repo.Migrations.CreateApp do
  use Ecto.Migration

  def change do
    create table(:apps) do
      add :name, :string
      add :slug, :string

      timestamps
    end
  end
end
