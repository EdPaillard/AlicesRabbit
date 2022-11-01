defmodule AlicesRabbit.Ticking.Clocks do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clocks" do
    field :status, :boolean, default: false
    field :time, :naive_datetime
    belongs_to :users, AlicesRabbit.Accounts.Users

    timestamps()
  end

  @doc false
  def changeset(clocks, attrs) do
    clocks
    |> cast(attrs, [:time, :status, :users_id])
    |> cast_assoc(:users, with: &AlicesRabbit.Accounts.Users.changeset/2)
    |> validate_required([:time, :status, :users_id])
  end
end
