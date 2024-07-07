defmodule MailerApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MailerAppWeb.Telemetry,
      MailerApp.Repo,
      {DNSCluster, query: Application.get_env(:mailer_app, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: MailerApp.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: MailerApp.Finch},
      # Start a worker by calling: MailerApp.Worker.start_link(arg)
      # {MailerApp.Worker, arg},
      # Start to serve requests, typically the last entry
      MailerAppWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MailerApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MailerAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
