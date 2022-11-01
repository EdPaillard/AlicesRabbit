defmodule AlicesRabbitWeb.WorkingtimesView do
  use AlicesRabbitWeb, :view
  alias AlicesRabbitWeb.WorkingtimesView

  def render("index.json", %{workingtimes: workingtimes}) do
    %{data: render_many(workingtimes, WorkingtimesView, "workingtimes.json")}
  end

  def render("show.json", %{workingtimes: workingtimes}) do
    %{data: render_one(workingtimes, WorkingtimesView, "workingtimes.json")}
  end

  def render("show_all.json", %{workingtimes: workingtimes}) do
    %{data: render_many(workingtimes, WorkingtimesView, "workingtimes.json")}
  end

  def render("workingtimes.json", %{workingtimes: workingtimes}) do
    if Map.get(workingtimes.users, :username) != nil do
      %{
        id: workingtimes.id,
        start: workingtimes.start,
        end: workingtimes.end,
        users_id: workingtimes.users_id,
        users: %{
          username: workingtimes.users.username,
          email: workingtimes.users.email
        }
      }
    else
      %{
        id: workingtimes.id,
        start: workingtimes.start,
        end: workingtimes.end,
        users_id: workingtimes.users_id,
      }
    end

  end
end
