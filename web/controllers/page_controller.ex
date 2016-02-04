defmodule Budgetparty.PageController do
  use Budgetparty.Web, :controller

  def index(conn, _params) do
  	conn
  	|> put_layout("cover.html")
    |> render "index.html"
  end
end
