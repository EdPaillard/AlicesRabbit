defmodule AlicesRabbit.Ticking do
  @moduledoc """
  The Ticking context.
  """

  import Ecto.Query, warn: false
  alias AlicesRabbit.Repo

  alias AlicesRabbit.Ticking.Clocks
  alias AlicesRabbit.Work.Workingtimes
  alias AlicesRabbit.Accounts.Users

  @doc """
  Returns the list of clocks.

  ## Examples

      iex> list_clocks()
      [%Clocks{}, ...]

  """
  def list_clocks do
    Repo.all(Clocks)
  end

  @doc """
  Gets a single clocks.

  Raises `Ecto.NoResultsError` if the Clocks does not exist.

  ## Examples

      iex> get_clocks!(123)
      %Clocks{}

      iex> get_clocks!(456)
      ** (Ecto.NoResultsError)

  """
  def get_clocks_by_user!(id) do
    Repo.all(from c in Clocks, where: c.users_id == ^id)
  end

  def get_clocks!(id) do
    Clocks
    |> Repo.get!(id)
    |> Repo.preload(:users)
  end

  @doc """
  Creates a clocks.

  ## Examples

      iex> create_clocks(%{field: value})
      {:ok, %Clocks{}}

      iex> create_clocks(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """

  def check_user_id(id) do
    if Enum.empty?(Repo.all(from u in Users, where: u.id == ^id)) do
      %{:error => "Bad user id"}
    else
      %{:ok => "Good id"}
    end
  end

  def check_id(id) do
    if Enum.empty?(Repo.all(from u in Users, where: u.id == ^id)) do
      %{:error => "Bad element id"}
    else
      %{:ok => "Good id"}
    end
  end

  def create_clocks(attrs \\ %{}) do
    %Clocks{}
    |> Clocks.changeset(attrs)
    |> Repo.insert()
  end

  def workingtime_user(id) do
    Repo.all(from c in Clocks, where: c.users_id == ^id, order_by: [desc: c.time])
  end

  def clock_create_workingtime(id) do
      user_clocks = workingtime_user(id)
      work_amount = [List.last(user_clocks)["time"], List.first(user_clocks)["time"]]
      %Workingtimes{}
      |> Clocks.changeset(%{"start" => List.first(work_amount), "end" => List.last(work_amount), "users_id" => id})
      delete_clocks(List.last(user_clocks))
      delete_clocks(List.first(user_clocks))
  end

  @doc """
  Updates a clocks.

  ## Examples

      iex> update_clocks(clocks, %{field: new_value})
      {:ok, %Clocks{}}

      iex> update_clocks(clocks, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_clocks(%Clocks{} = clocks, attrs) do
    clocks
    |> Clocks.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a clocks.

  ## Examples

      iex> delete_clocks(clocks)
      {:ok, %Clocks{}}

      iex> delete_clocks(clocks)
      {:error, %Ecto.Changeset{}}

  """
  def delete_clocks(%Clocks{} = clocks) do
    Repo.delete(clocks)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking clocks changes.

  ## Examples

      iex> change_clocks(clocks)
      %Ecto.Changeset{data: %Clocks{}}

  """
  def change_clocks(%Clocks{} = clocks, attrs \\ %{}) do
    Clocks.changeset(clocks, attrs)
  end
end
