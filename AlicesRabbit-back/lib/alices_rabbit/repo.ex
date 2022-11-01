defmodule AlicesRabbit.Repo do
  use Ecto.Repo,
    otp_app: :alices_rabbit,
    adapter: Ecto.Adapters.Postgres
end
