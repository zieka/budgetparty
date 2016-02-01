defmodule Budgetparty.NeedsController do
  use Budgetparty.Web, :controller

  alias Budgetparty.User
  alias Budgetparty.Needs

  plug :scrub_params, "needs" when action in [:create, :update]

  def index(conn, _params) do
    id = Plug.Conn.get_session(conn, :current_user)
    if id do
      user_email = Budgetparty.Repo.get(User, id).email
    end
    query = from(n in Needs, where: n.owner_id == ^user_email)
    needs = Repo.all(query)
    render(conn, "index.html", needs: needs)
  end

  def new(conn, _params) do
    changeset = Needs.changeset(%Needs{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"needs" => needs_params}) do
    changeset = Needs.changeset(%Needs{}, needs_params)

    case Repo.insert(changeset) do
      {:ok, _needs} ->
        conn
        |> put_flash(:info, "Needs created successfully.")
        |> redirect(to: needs_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    needs = Repo.get!(Needs, id)
    render(conn, "show.html", needs: needs)
  end

  def edit(conn, %{"id" => id}) do
    needs = Repo.get!(Needs, id)
    changeset = Needs.changeset(needs)
    render(conn, "edit.html", needs: needs, changeset: changeset)
  end

  def update(conn, %{"id" => id, "needs" => needs_params}) do
    needs = Repo.get!(Needs, id)
    changeset = Needs.changeset(needs, needs_params)

    case Repo.update(changeset) do
      {:ok, needs} ->
        conn
        |> put_flash(:info, "Needs updated successfully.")
        |> redirect(to: needs_path(conn, :show, needs))
      {:error, changeset} ->
        render(conn, "edit.html", needs: needs, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    needs = Repo.get!(Needs, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(needs)

    conn
    |> put_flash(:info, "Needs deleted successfully.")
    |> redirect(to: needs_path(conn, :index))
  end
end
