defmodule Budgetparty.PageController do
  use Budgetparty.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
