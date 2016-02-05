defmodule Budgetparty.RegistrationController do
  use Budgetparty.Web, :controller
  alias Budgetparty.User

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    conn
    |> put_layout("signin.html")
    |> render(changeset: changeset)
   # render conn, changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
  	changeset = User.changeset(%User{}, user_params)

  	case Budgetparty.Registration.create(changeset, Budgetparty.Repo) do
    	{:ok, changeset} ->
	      conn
      	|> put_flash(:info, "Your account was created")
      	|> redirect(to: "/login")
    	{:error, changeset} ->
    		conn
	      |> put_flash(:info, "Unable to create account")
        |> put_layout("signin.html")
      	|> render("new.html", changeset: changeset)
  	end
	end
end