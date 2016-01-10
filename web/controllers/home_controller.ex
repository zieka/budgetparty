defmodule Budgetparty.HomeController do
  use Budgetparty.Web, :controller

  alias Budgetparty.Needs
  alias Budgetparty.Wants

  def index(conn, _params) do
  	needs = Repo.all(Needs)
  	wants = Repo.all(Wants)
    render(conn, "index.html", needs: needs, wants: wants)
  end
end