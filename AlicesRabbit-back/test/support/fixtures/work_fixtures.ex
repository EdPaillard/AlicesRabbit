defmodule AlicesRabbit.WorkFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AlicesRabbit.Work` context.
  """

  @doc """
  Generate a workingtimes.
  """
  def workingtimes_fixture(attrs \\ %{}) do
    {:ok, workingtimes} =
      attrs
      |> Enum.into(%{
        end: ~N[2022-10-24 09:50:00],
        start: ~N[2022-10-24 09:50:00],
        user: "some user"
      })
      |> AlicesRabbit.Work.create_workingtimes()

    workingtimes
  end
end
