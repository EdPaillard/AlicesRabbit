defmodule AlicesRabbit.Repo.Migrations.CreateWorkingtimes do
  use Ecto.Migration

  def change do
    create table(:workingtimes) do
      add :start, :naive_datetime
      add :end, :naive_datetime
      add :users_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:workingtimes, [:users_id])
  end
end
