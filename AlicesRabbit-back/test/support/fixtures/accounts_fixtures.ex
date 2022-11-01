defmodule AlicesRabbit.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AlicesRabbit.Accounts` context.
  """

  @doc """
  Generate a users.
  """
  def users_fixture(attrs \\ %{}) do
    {:ok, users} =
      attrs
      |> Enum.into(%{
        email: "some email",
        username: "some username"
      })
      |> AlicesRabbit.Accounts.create_users()

    users
  end
end
