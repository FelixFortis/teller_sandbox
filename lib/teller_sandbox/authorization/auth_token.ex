defmodule TellerSandbox.Authorization.AuthToken do
  def validate_token(conn) do
    case get_token_from_auth(conn) do
      {:ok, auth_token} ->
        if validate_string(auth_token) && validate_slice(auth_token) do
          {:ok, auth_token}
        else
          {:error, "Authorization failed"}
        end

      :error ->
        {:error, "Authorization failed"}
    end
  end

  defp get_token_from_auth(conn) do
    try do
      auth_token =
        conn.req_headers
        |> Enum.into(%{})
        |> Map.fetch!("authorization")
        |> String.replace("Basic ", "")
        |> Base.decode64!()
        |> String.split(":")
        |> List.first()

      {:ok, auth_token}
    rescue
      RuntimeError -> :error
      KeyError -> :error
    end
  end

  defp validate_string(auth_token), do: Regex.match?(~r{\A\w+\z}, auth_token)

  defp validate_slice(auth_token), do: "test_" == String.slice(auth_token, 0..4)
end
