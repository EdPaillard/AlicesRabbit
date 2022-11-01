defmodule AlicesRabbit.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias AlicesRabbit.Repo

  alias AlicesRabbit.Accounts.Users
  alias AlicesRabbit.Ticking.Clocks

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%Users{}, ...]

  """
  def list_users do
    Repo.all(Users)
  end

  def check_user_id(id) do
    if Enum.empty?(Repo.all(from u in Users, where: u.id == ^id)) do
      %{:error => "Bad id"}
    else
      %{:ok => "Good id"}
    end
  end

  def check_email(email) do
    if Enum.empty?(Repo.all(from u in Users, where: u.email == ^email)) do
      %{:ok => "Email ok"}
    else
      %{:error => "Email already exists"}
    end
  end

  def get_user_by_params(email, username) do
    Repo.all(from u in Users, where: u.email == ^email and u.username == ^username)
  end

  def get_last_clock_by_user(id) do
    Repo.all(from c in Clocks, where: c.users_id == ^id)
  end

  @doc """
  Gets a single users.

  Raises `Ecto.NoResultsError` if the Users does not exist.

  ## Examples

      iex> get_users!(123)
      %Users{}

      iex> get_users!(456)
      ** (Ecto.NoResultsError)

  """
  def get_users!(id), do: Repo.get!(Users, id)

  def get_user_by_username(username) do
    Repo.all(from i in Users, where: i.username == ^username)
  end

  def get_user_by_email(email) do
    Repo.all(from i in Users, where: i.email == ^email)
  end

  @doc """
  Creates a users.

  ## Examples

      iex> create_users(%{field: value})
      {:ok, %Users{}}

      iex> create_users(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_users(attrs \\ %{}) do
    %Users{}
    |> Users.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a users.

  ## Examples

      iex> update_users(users, %{field: new_value})
      {:ok, %Users{}}

      iex> update_users(users, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_users(%Users{} = users, attrs) do
    users
    |> Users.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a users.

  ## Examples

      iex> delete_users(users)
      {:ok, %Users{}}

      iex> delete_users(users)
      {:error, %Ecto.Changeset{}}

  """
  def delete_users(%Users{} = users) do
    Repo.delete(users)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking users changes.

  ## Examples

      iex> change_users(users)
      %Ecto.Changeset{data: %Users{}}

  """
  def change_users(%Users{} = users, attrs \\ %{}) do
    Users.changeset(users, attrs)
  end
end
