defmodule Budgetparty.SessionController do
  use Budgetparty.Web, :controller

  def new(conn, _params) do
    conn
    |> put_layout("signin.html")
    |> render "new.html"
  end

  def create(conn, %{"session" => session_params}) do
  	case Budgetparty.Session.login(session_params, Budgetparty.Repo) do
    	{:ok, user} ->
      	conn
      	|> put_session(:current_user, user.id)
      	|> put_flash(:info, "Logged in")
      	|> redirect(to: "/home")
    	:error ->
      	conn
      	|> put_flash(:info, "Wrong email or password")
        |> put_layout("signin.html")
      	|> render("new.html")
  	end
	end

  def delete(conn, _) do
    conn
    |> delete_session(:current_user)
    |> put_flash(:info, "Logged out")
    |> redirect(to: "/")
  end
end