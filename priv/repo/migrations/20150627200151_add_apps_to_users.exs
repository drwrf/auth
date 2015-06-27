defmodule Auth.Repo.Migrations.AddAppsToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :app_id, references(:apps)
    end
  end
end
