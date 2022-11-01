defmodule AlicesRabbitWeb.UsersController do
  use AlicesRabbitWeb, :controller

  alias AlicesRabbit.Accounts
  alias AlicesRabbit.Accounts.Users

  action_fallback AlicesRabbitWeb.FallbackController

  # def index(conn, %{"email" => email, "username" => username}) do
  #   cond do
  #     email == nil ->
  #       users = Accounts.list_users()
  #       users = AlicesRabbit.Repo.preload(users, [:workingtimes, :clocks])
  #       render(conn, "index.json", users: users)

  #     username == nil ->
  #       users = Accounts.list_users()
  #       users = AlicesRabbit.Repo.preload(users, [:workingtimes, :clocks])
  #       render(conn, "index.json", users: users)

  #     email != nil ->
  #       users = Accounts.get_user_by_params(email, username)
  #       users = AlicesRabbit.Repo.preload(users, [:workingtimes, :clocks])
  #       render(conn, "index.json", users: users)

  #   end
  # end

  def index(conn, params) do
    email = params["email"]
    username = params["username"]

    if is_nil(email) or is_nil(username) do
      users = Accounts.list_users()
      users = AlicesRabbit.Repo.preload(users, [:workingtimes, :clocks])
      render(conn, "index.json", users: users)
    else
      users = Accounts.get_user_by_params(email, username)
      users = AlicesRabbit.Repo.preload(users, [:workingtimes, :clocks])
      render(conn, "index.json", users: users)
    end
  end

  def create(conn, %{"username" => username, "email" => email}) do
    checkEmail = Accounts.check_email(email)
    params = %{"username" => username, "email" => email, }
    with {:ok, %Users{} = users} <- Accounts.create_users(params) do
      if checkEmail[:error] != nil do
        conn
        |> json(checkEmail)
      else
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.users_path(conn, :show, users))
        |> render("show.json", users: users)
      end
    end
  end

  def create(conn, _) do
    conn
    |> json(%{:error => "Missing arguments"})
  end

  # def index(conn, params) do
#     #username = conn.query_params['username']
#     #email = conn.query_params['email']
#     username = Map.get(params, "username", nil)
#     email = Map.get(params, "email", nil)

#     if username != nil and email != nil do
#       users = Accounts.get_user_by_params(username, email)
#       render(conn, "index.json", users: users)
#     else
#       if username == nil and email != nil do
#         users = Accounts.get_user_by_email(email)
#         render(conn, "index.json", users: users)
#       else
#         if username != nil and email == nil do
#           users = Accounts.get_user_by_username(username)
#           render(conn, "index.json", users: users)
#         else
#           users = Accounts.list_users()
#           render(conn, "index.json", users: users)
#         end
#       end
#     end
#   end

  def show(conn, %{"id" => id}) do
    checkUser = Accounts.check_user_id(id)
    if checkUser[:error] != nil do
      conn
      |> json(checkUser)
    else
      users = Accounts.get_users!(id)
      users = AlicesRabbit.Repo.preload(users, [:workingtimes, :clocks])
      render(conn, "show.json", users: users)
    end
  end

  def update(conn, %{"id" => id, "users" => users_params}) do
    checkUser = Accounts.check_user_id(id)
    if checkUser[:error] != nil do
      conn
      |> json(checkUser)
    else
      users = Accounts.get_users!(id)
      with {:ok, %Users{} = users} <- Accounts.update_users(users, users_params) do
        render(conn, "show.json", users: users)
      end
    end
  end

  def delete(conn, %{"id" => id}) do
    checkUser = Accounts.check_user_id(id)
    if checkUser[:error] != nil do
      conn
      |> json(checkUser)
    else
      users = Accounts.get_users!(id)
      with {:ok, %Users{}} <- Accounts.delete_users(users) do
        send_resp(conn, :no_content, "")
      end
    end
  end
end
