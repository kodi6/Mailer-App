defmodule MailerApp.Repo do
  use Ecto.Repo,
    otp_app: :mailer_app,
    adapter: Ecto.Adapters.Postgres
end
