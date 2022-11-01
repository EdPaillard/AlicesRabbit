defmodule AlicesRabbit.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      AlicesRabbit.Repo,
      # Start the Telemetry supervisor
      AlicesRabbitWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: AlicesRabbit.PubSub},
      # Start the Endpoint (http/https)
      AlicesRabbitWeb.Endpoint
      # Start a worker by calling: AlicesRabbit.Worker.start_link(arg)
      # {AlicesRabbit.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AlicesRabbit.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AlicesRabbitWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
