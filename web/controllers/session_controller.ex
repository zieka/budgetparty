defmodule Budgetparty.SessionController do
  use Budgetparty.Web, :controller

  def new(conn, _params) do
    render conn, "new.html"
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
      	|> render("new.html")
  	end
	end
end