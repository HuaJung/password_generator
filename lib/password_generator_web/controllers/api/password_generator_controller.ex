defmodule PasswordGeneratorWeb.Api.PasswordGeneratorController do
  use PasswordGeneratorWeb, :controller


  def api_generate(conn, params) do
    case PasswordGenerator.generate(params) do
      {:ok, password} -> json(conn, %{password: password})
      {:error, error} ->
        conn
        |> put_status(400)
        |> json(%{error: error})
    end
  end
end
