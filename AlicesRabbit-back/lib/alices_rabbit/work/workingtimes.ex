defmodule AlicesRabbit.Work.Workingtimes do
  use Ecto.Schema
  import Ecto.Changeset
  #import Ecto.Query

  schema "workingtimes" do
    field :end, :naive_datetime
    field :start, :naive_datetime
    belongs_to :users, AlicesRabbit.Accounts.Users

    timestamps()
  end

  @doc false
  def changeset(workingtimes, attrs) do
    workingtimes
    |> cast(attrs, [:start, :end, :users_id])
    |> cast_assoc(:users, with: &AlicesRabbit.Accounts.Users.changeset/2)
    |> validate_required([:start, :end, :users_id])
  end
end

# params = attrs ++ user
    # user = AlicesRabbit.Repo.all(from u in AlicesRabbit.Accounts.Users, where: u.id == ^attrs["users_id"])
    # |> AlicesRabbit.Repo.get!(attrs["users_id"])
    # |> AlicesRabbit.Repo.preload(:users)
    #|> Ecto.build_assoc(workingtimes, :users, %{id: attrs["users_id"]})
