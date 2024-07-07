defmodule MailerAppWeb.SendMailLive.Index do
  use MailerAppWeb, :live_view

  import Swoosh.Email

  alias MailerApp.TokenFetcher


  def render(assigns) do
    ~H"""
    <.button phx-click="send">Send Mail</.button>
    """
  end

  def handle_event("send", _params, socket) do
    email =
      new()
      |> to("sender@gmail.com")
      |> from("receiver@gmail.com")
      |> subject("Welcome to Our Phoenix App!")
      |> html_body("<h1>Welcome!</h1><p>Thank! you for joining our Phoenix app. We're excited to have you on board!</p>")

      MailerApp.Mailer.deliver(email, access_token: TokenFetcher.get_access_token())
    {:noreply, socket}
  end
end
