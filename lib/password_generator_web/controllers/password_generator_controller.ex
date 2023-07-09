defmodule PasswordGeneratorWeb.PasswordGeneratorController do
  use PasswordGeneratorWeb, :controller


  def index(conn, _param) do
    password_length = password_length_selection()
    password =""
    conn
    |> assign(:password_length, password_length)
    |> assign(:password, password)
    |> put_layout(html: :admin)
    |> render(:index)
  end

  def generate(conn, %{"password" => password_params}) do
    password_length = password_length_selection()
    {:ok, password} = PasswordGenerator.generate(password_params)

    conn
    |> assign(:password_length, password_length)
    |> assign(:password, password)
    |> put_layout(html: :admin)
    |> render(:index)
  end

  defp password_length_selection do
    _password_length = [
      Weak: Enum.map(6..15, & &1),
      Strong: Enum.map(16..88, & &1),
      Unbelievable: [100, 150]
    ]
  end

end
