defmodule AlicesRabbit.Repo.Migrations.CreateClocks do
  use Ecto.Migration

  def change do
    create table(:clocks) do
      add :time, :naive_datetime
      add :status, :boolean, default: false, null: false
      add :users_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:clocks, [:users_id])
  end
end
