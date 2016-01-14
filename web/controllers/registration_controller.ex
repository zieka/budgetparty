defmodule Budgetparty.RegistrationController do
  use Budgetparty.Web, :controller
  alias Budgetparty.User

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
  	changeset = User.changeset(%User{}, user_params)

  	case Budgetparty.Registration.create(changeset, Budgetparty.Repo) do
    	{:ok, changeset} ->
	      conn
      	|> put_flash(:info, "Your account was created")
      	|> redirect(to: "/posts")

    	{:error, changeset} ->
    		conn
	      |> put_flash(:info, "Unable to create account")
      	|> render("new.html", changeset: changeset)
  	end
	end
end