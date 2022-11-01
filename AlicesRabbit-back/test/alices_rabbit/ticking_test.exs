defmodule AlicesRabbit.TickingTest do
  use AlicesRabbit.DataCase

  alias AlicesRabbit.Ticking

  describe "clocks" do
    alias AlicesRabbit.Ticking.Clocks

    import AlicesRabbit.TickingFixtures

    @invalid_attrs %{status: nil, time: nil, user: nil}

    test "list_clocks/0 returns all clocks" do
      clocks = clocks_fixture()
      assert Ticking.list_clocks() == [clocks]
    end

    test "get_clocks!/1 returns the clocks with given id" do
      clocks = clocks_fixture()
      assert Ticking.get_clocks!(clocks.id) == clocks
    end

    test "create_clocks/1 with valid data creates a clocks" do
      valid_attrs = %{status: true, time: ~N[2022-10-24 09:48:00], user: "some user"}

      assert {:ok, %Clocks{} = clocks} = Ticking.create_clocks(valid_attrs)
      assert clocks.status == true
      assert clocks.time == ~N[2022-10-24 09:48:00]
      assert clocks.user == "some user"
    end

    test "create_clocks/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ticking.create_clocks(@invalid_attrs)
    end

    test "update_clocks/2 with valid data updates the clocks" do
      clocks = clocks_fixture()
      update_attrs = %{status: false, time: ~N[2022-10-25 09:48:00], user: "some updated user"}

      assert {:ok, %Clocks{} = clocks} = Ticking.update_clocks(clocks, update_attrs)
      assert clocks.status == false
      assert clocks.time == ~N[2022-10-25 09:48:00]
      assert clocks.user == "some updated user"
    end

    test "update_clocks/2 with invalid data returns error changeset" do
      clocks = clocks_fixture()
      assert {:error, %Ecto.Changeset{}} = Ticking.update_clocks(clocks, @invalid_attrs)
      assert clocks == Ticking.get_clocks!(clocks.id)
    end

    test "delete_clocks/1 deletes the clocks" do
      clocks = clocks_fixture()
      assert {:ok, %Clocks{}} = Ticking.delete_clocks(clocks)
      assert_raise Ecto.NoResultsError, fn -> Ticking.get_clocks!(clocks.id) end
    end

    test "change_clocks/1 returns a clocks changeset" do
      clocks = clocks_fixture()
      assert %Ecto.Changeset{} = Ticking.change_clocks(clocks)
    end
  end
end
