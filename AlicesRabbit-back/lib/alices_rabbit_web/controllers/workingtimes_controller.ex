defmodule AlicesRabbitWeb.WorkingtimesController do
  use AlicesRabbitWeb, :controller
  require Logger

  alias AlicesRabbit.Work
  alias AlicesRabbit.Work.Workingtimes
  action_fallback AlicesRabbitWeb.FallbackController

  def index(conn, _params) do
    workingtimes = Work.list_workingtimes()
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def create(conn, %{"users_id" => usersID, "start" => start, "end" => endtime}) do #params
    params = %{"users_id" => usersID, "start" => start, "end" => endtime}
    with {:ok, %Workingtimes{} = workingtimes} <- Work.create_workingtimes(params) do
      if endtime < start do
        conn
        |> json(%{:error => "Bad argument: endtime earlier than starting time"})
      else
        conn
        |> put_status(:created)
        #|> put_resp_header("location", Routes.workingtimes_path(conn, :show, workingtimes))
        |> render("show.json", workingtimes: workingtimes)
      end
    end
  end

  def create(conn, _) do
    conn
    |> json(%{:error => "Missing arguments"})
  end

  def show(conn, %{"id" => id, "users_id" => userID}) do
    check = Work.check_id(id)
    checkUser = Work.check_user_id(userID)
    if check[:error] != nil or checkUser[:error] != nil do
      if check[:error] != nil do
        conn
        |> json(check)
      else
        conn
        |> json(checkUser)
      end
    else
      workingtimes = Work.get_workingtimes_by_user_id(id, userID)
      workingtimes = AlicesRabbit.Repo.preload(workingtimes, :users)
      render(conn, "index.json", workingtimes: workingtimes)
    end
  end

  def show_all(conn, %{"users_id" => id, "start" => start, "end" => endtime }) do
    check = Work.check_user_id(id)
    if check[:error] do
      conn
      |> json(check)
    else
      workingtimes = Work.get_workingtimes_by_user!(id, start, endtime)
      render(conn, "show_all.json", workingtimes: workingtimes)
    end
  end

  def show_all(conn, %{"users_id" => id}) do
    check = Work.check_user_id(id)
    if check[:error] do
      conn
      |> json(check)
    else
      workingtimes = Work.get_all_workingtimes_by_user(id)
      render(conn, "show_all.json", workingtimes: workingtimes)
    end
  end

  def update(conn, %{"id" => id, "start" => start, "end" => endtime}) do
    if endtime < start do
      conn
      |> json(%{:error => "Bad argument: endtime earlier than starting time"})
    else
      check = Work.check_id(id)
      if check[:error] do
        conn
        |> json(check)
      else
        workingtimes = Work.get_workingtimes!(id)
        workingtimes_params = %{"start" => start, "end" => endtime}
        with {:ok, %Workingtimes{} = workingtimes} <- Work.update_workingtimes(workingtimes, workingtimes_params) do
          render(conn, "show.json", workingtimes: workingtimes)
        end
      end
    end
  end

  def delete(conn, %{"id" => id}) do
    check = Work.check_id(id)
    if check[:error] do
      conn
      |> json(check)
    else
      workingtimes = Work.get_workingtimes!(id)

      with {:ok, %Workingtimes{}} <- Work.delete_workingtimes(workingtimes) do
        conn
        |> json(%{:ok => "Workingtime successfully deleted"})
      end
    end
  end
end
