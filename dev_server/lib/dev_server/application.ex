defmodule DevServer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      DevServerWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: DevServer.PubSub},
      # Start the Endpoint (http/https)
      DevServerWeb.Endpoint
      # Start a worker by calling: DevServer.Worker.start_link(arg)
      # {DevServer.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DevServer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DevServerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
