defmodule Auth.Repo.Migrations.AddDeletedFlagToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :is_deleted, :bool, default: fragment("false")
    end
  end
end
