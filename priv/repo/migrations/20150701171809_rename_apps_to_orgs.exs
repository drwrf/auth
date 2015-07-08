defmodule Auth.Repo.Migrations.RenameAppsToOrgs do
  use Ecto.Migration

  def change do
    create table(:orgs) do
      add :name, :string
      add :slug, :string

      timestamps
    end

    alter table(:users) do
      add :org_id, references(:orgs)
      remove :app_id
    end

    drop table(:apps)
  end
end
