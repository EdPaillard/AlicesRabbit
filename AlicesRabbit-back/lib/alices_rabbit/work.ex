defmodule AlicesRabbit.Work do
  @moduledoc """
  The Work context.
  """

  import Ecto.Query, warn: false
  alias AlicesRabbit.Repo

  alias AlicesRabbit.Work.Workingtimes
  alias AlicesRabbit.Accounts.Users

  @doc """
  Returns the list of workingtimes.

  ## Examples

      iex> list_workingtimes()
      [%Workingtimes{}, ...]

  """
  def list_workingtimes do
    Repo.all(Workingtimes)
  end

  @doc """
  Gets a single workingtimes.

  Raises `Ecto.NoResultsError` if the Workingtimes does not exist.

  ## Examples

      iex> get_workingtimes!(123)
      %Workingtimes{}

      iex> get_workingtimes!(456)
      ** (Ecto.NoResultsError)

  """

  def check_id(id) do
    if Enum.empty?(Repo.all(from w in Workingtimes, where: w.id == ^id)) do
      %{:error => "Bad element id"}
    else
      %{:ok => "Good id"}
    end
  end

  def check_user_id(id) do
    if Enum.empty?(Repo.all(from u in Users, where: u.id == ^id)) do
      %{:error => "Bad user id"}
    else
      %{:ok => "Good id"}
    end
  end

  def get_workingtimes!(id) do
    if Enum.empty?(Repo.all(from w in Workingtimes, where: w.id == ^id)) do
      %{:error => "Bad id"}
    else
      Workingtimes
      |> Repo.get!(id)
      |> Repo.preload(:users)
    end
  end

  def get_workingtimes_by_user_id(id, userID) do
    Repo.all(from w in Workingtimes, where: w.users_id == ^userID and w.id == ^id)
    |> Repo.preload(:users)
  end

  def get_workingtimes_by_user!(id, start, endtime) do
    Repo.all(from w in Workingtimes, where: w.users_id == ^id and w.start >= ^start and w.end <= ^endtime)
    |>  Repo.preload(:users)
  end

  def get_all_workingtimes_by_user(id) do
    Repo.all(from w in Workingtimes, where: w.users_id == ^id)
    |> Repo.preload(:users)
  end

  @doc """
  Creates a workingtimes.

  ## Examples

      iex> create_workingtimes(%{field: value})
      {:ok, %Workingtimes{}}

      iex> create_workingtimes(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_workingtimes(attrs \\ %{}) do
    %Workingtimes{}
    |> Workingtimes.changeset(attrs)
    |> Repo.insert()
    #IO.inspect(item: "HEOHEHEHEHHE", label: "YOUHHHHHHH")
  end

  @doc """
  Updates a workingtimes.

  ## Examples

      iex> update_workingtimes(workingtimes, %{field: new_value})
      {:ok, %Workingtimes{}}

      iex> update_workingtimes(workingtimes, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_workingtimes(%Workingtimes{} = workingtimes, attrs) do
    workingtimes
    |> Workingtimes.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a workingtimes.

  ## Examples

      iex> delete_workingtimes(workingtimes)
      {:ok, %Workingtimes{}}

      iex> delete_workingtimes(workingtimes)
      {:error, %Ecto.Changeset{}}

  """
  def delete_workingtimes(%Workingtimes{} = workingtimes) do
    Repo.delete(workingtimes)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking workingtimes changes.

  ## Examples

      iex> change_workingtimes(workingtimes)
      %Ecto.Changeset{data: %Workingtimes{}}

  """
  def change_workingtimes(%Workingtimes{} = workingtimes, attrs \\ %{}) do
    Workingtimes.changeset(workingtimes, attrs)
  end
end
