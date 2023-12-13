defmodule Classics.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ClassicsWeb.Telemetry,
      Classics.Repo,
      {DNSCluster, query: Application.get_env(:classics, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Classics.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Classics.Finch},
      # Start a worker by calling: Classics.Worker.start_link(arg)
      # {Classics.Worker, arg},
      # Start to serve requests, typically the last entry
      ClassicsWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Classics.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ClassicsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
