defmodule AlicesRabbit.WorkTest do
  use AlicesRabbit.DataCase

  alias AlicesRabbit.Work

  describe "workingtimes" do
    alias AlicesRabbit.Work.Workingtimes

    import AlicesRabbit.WorkFixtures

    @invalid_attrs %{end: nil, start: nil, user: nil}

    test "list_workingtimes/0 returns all workingtimes" do
      workingtimes = workingtimes_fixture()
      assert Work.list_workingtimes() == [workingtimes]
    end

    test "get_workingtimes!/1 returns the workingtimes with given id" do
      workingtimes = workingtimes_fixture()
      assert Work.get_workingtimes!(workingtimes.id) == workingtimes
    end

    test "create_workingtimes/1 with valid data creates a workingtimes" do
      valid_attrs = %{end: ~N[2022-10-24 09:50:00], start: ~N[2022-10-24 09:50:00], user: "some user"}

      assert {:ok, %Workingtimes{} = workingtimes} = Work.create_workingtimes(valid_attrs)
      assert workingtimes.end == ~N[2022-10-24 09:50:00]
      assert workingtimes.start == ~N[2022-10-24 09:50:00]
      assert workingtimes.user == "some user"
    end

    test "create_workingtimes/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Work.create_workingtimes(@invalid_attrs)
    end

    test "update_workingtimes/2 with valid data updates the workingtimes" do
      workingtimes = workingtimes_fixture()
      update_attrs = %{end: ~N[2022-10-25 09:50:00], start: ~N[2022-10-25 09:50:00], user: "some updated user"}

      assert {:ok, %Workingtimes{} = workingtimes} = Work.update_workingtimes(workingtimes, update_attrs)
      assert workingtimes.end == ~N[2022-10-25 09:50:00]
      assert workingtimes.start == ~N[2022-10-25 09:50:00]
      assert workingtimes.user == "some updated user"
    end

    test "update_workingtimes/2 with invalid data returns error changeset" do
      workingtimes = workingtimes_fixture()
      assert {:error, %Ecto.Changeset{}} = Work.update_workingtimes(workingtimes, @invalid_attrs)
      assert workingtimes == Work.get_workingtimes!(workingtimes.id)
    end

    test "delete_workingtimes/1 deletes the workingtimes" do
      workingtimes = workingtimes_fixture()
      assert {:ok, %Workingtimes{}} = Work.delete_workingtimes(workingtimes)
      assert_raise Ecto.NoResultsError, fn -> Work.get_workingtimes!(workingtimes.id) end
    end

    test "change_workingtimes/1 returns a workingtimes changeset" do
      workingtimes = workingtimes_fixture()
      assert %Ecto.Changeset{} = Work.change_workingtimes(workingtimes)
    end
  end
end
