defmodule Budgetparty.HomeController do
  use Budgetparty.Web, :controller
  alias Budgetparty.User

  alias Budgetparty.Needs
  alias Budgetparty.Wants

  def index(conn, _params) do
    validate(conn)
		user_email = current_uid(conn)
  	query = from(n in Needs, where: n.owner_id == ^user_email)
  	query2 = from(w in Wants, where: w.owner_id == ^user_email)

  	needs = Repo.all(query)
  	wants = Repo.all(query2)
    conn
    #|> put_layout("dashboard.html")
    #|> render( "index.html", needs: needs, wants: wants)
    render(conn, "index.html", needs: needs, wants: wants)
  end

  def current_uid(conn) do
    uid = Plug.Conn.get_session(conn, :current_user)
    if uid do
      Budgetparty.Repo.get(User, uid).email
    end
  end

  def validate(conn) do
    if is_nil(current_uid(conn)) do
      conn |> redirect(to: "/") |> halt
    end
  end
end