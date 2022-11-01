defmodule AlicesRabbit.TickingFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AlicesRabbit.Ticking` context.
  """

  @doc """
  Generate a clocks.
  """
  def clocks_fixture(attrs \\ %{}) do
    {:ok, clocks} =
      attrs
      |> Enum.into(%{
        status: true,
        time: ~N[2022-10-24 09:48:00],
        user: "some user"
      })
      |> AlicesRabbit.Ticking.create_clocks()

    clocks
  end
end
