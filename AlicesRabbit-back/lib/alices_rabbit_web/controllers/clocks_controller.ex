defmodule AlicesRabbitWeb.ClocksController do
  use AlicesRabbitWeb, :controller

  alias AlicesRabbit.Ticking
  alias AlicesRabbit.Ticking.Clocks
  alias AlicesRabbit.Work
  alias AlicesRabbit.Accounts

  action_fallback AlicesRabbitWeb.FallbackController

  def index(conn, _params) do
    clocks = Ticking.list_clocks()
    render(conn, "index.json", clocks: clocks)
  end

  def create(conn, %{"status" => status, "time" => time, "users_id" => userID}) do
    utcTime = DateTime.utc_now()
    correcttime = DateTime.add(utcTime, 7200, :second)
    formatUTCTime = DateTime.truncate(correcttime, :second)
    truetime = DateTime.to_naive(formatUTCTime)


    if status === false do
      clock = Accounts.get_last_clock_by_user(userID)
      if time == nil do
        Work.create_workingtimes(%{start: NaiveDateTime.to_string(List.first(clock).time), end: truetime, users_id: userID})
      else
        Work.create_workingtimes(%{start: List.first(clock).time, end: time, users_id: userID})
      end
    end


    if time == nil do
      clocks_params = %{"status" => status, "time" => truetime, "users_id" => userID}
      with {:ok, %Clocks{} = clocks} <- Ticking.create_clocks(clocks_params) do
        conn
        |> put_status(:created)
        #|> put_resp_header("location", Routes.clocks_path(conn, :show, clocks))
        |> render("show.json", clocks: clocks)
      end
    else
      clocks_params = %{"status" => status, "time" => time, "users_id" => userID}
      with {:ok, %Clocks{} = clocks} <- Ticking.create_clocks(clocks_params) do
        conn
        |> put_status(:created)
        #|> put_resp_header("location", Routes.clocks_path(conn, :show, clocks))
        |> render("show.json", clocks: clocks)
      end
    end
  end

  def show(conn, %{"users_id" => id}) do
    check = Work.check_user_id(id)
    if check[:error] do
      conn
      |> json(check)
    else
      clocks = Ticking.get_clocks_by_user!(id)
      clocks = AlicesRabbit.Repo.preload(clocks, :users)
      render(conn, "index.json", clocks: clocks)
    end
  end

  def update(conn, clocks_params) do
    check = Work.check_id(clocks_params["id"])
    checkUser = Work.check_user_id(clocks_params["users_id"])
    if check[:error] != nil or checkUser[:error] != nil do
      if check[:error] != nil do
        conn
        |> json(check)
      else
        conn
        |> json(checkUser)
      end
    else
      clocks = Ticking.get_clocks!(clocks_params["id"])

      with {:ok, %Clocks{} = clocks} <- Ticking.update_clocks(clocks, clocks_params) do
        render(conn, "show.json", clocks: clocks)
      end
    end
  end

  def delete(conn, %{"id" => id}) do
    check = Work.check_id(id)
    if check[:error] do
      conn
      |> json(check)
    else
      clocks = Ticking.get_clocks!(id)

      with {:ok, %Clocks{}} <- Ticking.delete_clocks(clocks) do
        conn
        |> json(%{success: "Clock deleted successfully"})
      end
    end
  end
end
