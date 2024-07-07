defmodule MailerApp.TokenFetcher do
  def get_access_token() do
    body =
      Jason.encode!(%{
        "client_id" => "2913701414-7tjjvrc7t2gi565l3vhd786cti282ifi.apps.googleusercontent.com",
        "client_secret" => "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",
        "grant_type" => "refresh_token",
        "refresh_token" =>
          "1//0gxUMQUIPfVxLCgYIARAAGBASNwF-L9IryAaZUr3p0SfTtK84MvOwm6hXN42_RajIKGUgi77BHNMv3X0NgnZ5y6WckYZhSshLMNA"
      })
    body
    |> request()
    |> response()
    |> access_token()
  end

  defp response({:ok, %Finch.Response{body: body}}) do
    Jason.decode!(body)
  end

  defp request(body) do
    headers = headers()

    Finch.build(:post, "https://oauth2.googleapis.com/token", headers, body)
    |> Finch.request(MailerApp.Finch)
  end

  defp headers do
    [{"content-type", "application/json"}]
  end

  defp access_token(body) do
    Map.get(body, "access_token")
  end
end
