defmodule Budgetparty.HomeController do
  use Budgetparty.Web, :controller
  alias Budgetparty.User

  alias Budgetparty.Needs
  alias Budgetparty.Wants

  def index(conn, _params) do
		id = Plug.Conn.get_session(conn, :current_user)
		if id do
			user_email = Budgetparty.Repo.get(User, id).email
		end
  	query = from(n in Needs, where: n.owner_id == ^user_email)
  	query2 = from(w in Wants, where: w.owner_id == ^user_email)

  	needs = Repo.all(query)
  	wants = Repo.all(query2)
    render(conn, "index.html", needs: needs, wants: wants)

  end
end