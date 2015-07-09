defmodule Auth.Repo.Migrations.CreateLogin do
  use Ecto.Migration

  def change do
    create table(:logins) do
      add :token, :string

      add :user_id, references(:users)
      add :org_id, references(:orgs)

      timestamps
    end

  end
end
