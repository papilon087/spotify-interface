defmodule SpotifyInterface.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      SpotifyInterfaceWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:spotify_interface, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: SpotifyInterface.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: SpotifyInterface.Finch},
      # Start a worker by calling: SpotifyInterface.Worker.start_link(arg)
      # {SpotifyInterface.Worker, arg},
      # Start to serve requests, typically the last entry
      SpotifyInterfaceWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SpotifyInterface.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SpotifyInterfaceWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
