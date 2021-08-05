defmodule TellerSandbox.AuthToken do
  def validate_token(conn) do
    case get_token_from_header(conn) do
      {:ok, token} ->
        if validate_string(token) && validate_slice(token) do
          {:ok, token}
        else
          {:error, "Invalid token"}
        end

      :error ->
        {:error, "Invalid token"}
    end
  end

  defp get_token_from_header(conn) do
    conn.req_headers
    |> Enum.into(%{})
    |> Map.fetch("token")
  end

  defp validate_string(token), do: String.valid?(token)

  defp validate_slice(token), do: "test_" == String.slice(token, 0..4)
end
