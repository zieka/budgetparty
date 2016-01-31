defmodule Budgetparty.HomeController do
  use Budgetparty.Web, :controller

  alias Budgetparty.Needs
  alias Budgetparty.Wants

  def index(conn, _params) do
  	query = from(n in Needs, where: n.owner_id == "placeholder")
  	query2 = from(w in Wants, where: w.owner_id == "placeholder")

  	needs = Repo.all(query)
  	wants = Repo.all(query2)
    render(conn, "index.html", needs: needs, wants: wants)
  end
end