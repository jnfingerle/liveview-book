defmodule Pento.Repo.Migrations.AddUsername do
  use Ecto.Migration

  def up do
    alter table(:users) do
      add :username, :string, size: 100
    end

    create unique_index(:users, :username)

    execute "UPDATE users SET username = email;"

    alter table(:users) do
      modify :username, :string, null: false
    end
  end

  def down do
    alter table(:users) do
      remove :username
    end
  end
end
