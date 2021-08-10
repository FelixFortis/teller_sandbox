defmodule TellerSandbox.Authorization.AuthToken do
  def validate_token(conn) do
    case get_token_from_auth(conn) do
      {:ok, token} ->
        if validate_string(token) && validate_slice(token) do
          {:ok, token}
        else
          {:error, "Authorization failed"}
        end

      :error ->
        {:error, "Authorization failed"}
    end
  end

  defp get_token_from_auth(conn) do
    try do
      token =
        conn.req_headers
        |> Enum.into(%{})
        |> Map.fetch!("authorization")
        |> String.replace("Basic ", "")
        |> Base.decode64!()
        |> String.split(":")
        |> List.first()

      {:ok, token}
    rescue
      RuntimeError -> :error
      KeyError -> :error
    end
  end

  defp validate_string(token), do: Regex.match?(~r{\A\w+\z}, token)

  defp validate_slice(token), do: "test_" == String.slice(token, 0..4)
end
