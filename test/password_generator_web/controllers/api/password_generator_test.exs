defmodule PasswordGeneratorWeb.Api.PasswordGeneratorTest do
  use PasswordGeneratorWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "generates a password" do
    test "generates password with only length passed", %{conn: conn} do
      conn = post(conn, url(~p"/api/password-generator"), %{"length" => "5"})
      assert %{"password" => _pass} = json_response(conn, 200)
    end

    test "generates password with one option", %{conn: conn} do
      options = %{"length" => "5", "numbers"=> "true"}
      conn = post(conn, url(~p"/api/password-generator"), options)
      assert %{"password" => _pass} = json_response(conn, 200)
    end
  end

    describe "returns errors" do
    test "error when no options", %{conn: conn} do
      conn = post(conn, url(~p"/api/password-generator"), %{})
      assert %{"error" => _error} = json_response(conn, 400)
    end

    test "error when length not integer", %{conn: conn} do
      conn = post(conn, url(~p"/api/password-generator"), %{"length" => "ab"})
      assert %{"error" => _error} = json_response(conn, 400)
    end

    test "error when optoins not booleans", %{conn: conn} do
      conn = post(conn, url(~p"/api/password-generator"), %{"length" => "5", "invalid" => "invalid"})
      assert %{"error" => _error} = json_response(conn, 400)
    end

    test "error when not valid options", %{conn: conn} do
      conn = post(conn, url(~p"/api/password-generator"), %{"length" => "5", "invalid" => "true"})
      assert %{"error" => _error} = json_response(conn, 400)
    end
  end
end
