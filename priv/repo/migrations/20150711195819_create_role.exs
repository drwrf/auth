defmodule Auth.Repo.Migrations.CreateRole do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :name, :string

      add :user_id, references(:users)
      add :org_id, references(:orgs)

      timestamps
    end

  end
end
