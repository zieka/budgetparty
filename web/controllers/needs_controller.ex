defmodule Budgetparty.NeedsController do
  use Budgetparty.Web, :controller

  alias Budgetparty.User
  alias Budgetparty.Needs

  plug :scrub_params, "needs" when action in [:create, :update]

  def index(conn, _params) do
    user_email = current_uid(conn)
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

    if changeset.changes.owner_id == current_uid(conn) do
      case Repo.insert(changeset) do
        {:ok, _needs} ->
          conn
          |> put_flash(:info, "Needs created successfully.")
          |> redirect(to: needs_path(conn, :index))
        {:error, changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    else
      conn |> put_flash(:error, "Don't be evil.") |> redirect(to: "/") |> halt
    end
  end

  def show(conn, %{"id" => id}) do
    needs = Repo.get!(Needs, id)

    if needs.owner_id == current_uid(conn) do
      render(conn, "show.html", needs: needs)
    else
      conn |> put_flash(:error, "Don't be evil.") |> redirect(to: "/") |> halt
    end
  end

  def edit(conn, %{"id" => id}) do
    needs = Repo.get!(Needs, id)
    changeset = Needs.changeset(needs)

    if needs.owner_id == current_uid(conn) do
      render(conn, "edit.html", needs: needs, changeset: changeset)
    else
      conn |> put_flash(:error, "Don't be evil.") |> redirect(to: "/") |> halt
    end
  end

  def update(conn, %{"id" => id, "needs" => needs_params}) do
    needs = Repo.get!(Needs, id)
    changeset = Needs.changeset(needs, needs_params)

    if changeset.changes.owner_id == current_uid(conn) do
      case Repo.update(changeset) do
        {:ok, needs} ->
          conn
          |> put_flash(:info, "Need updated successfully.")
          |> redirect(to: needs_path(conn, :show, needs))
        {:error, changeset} ->
          render(conn, "edit.html", needs: needs, changeset: changeset)
      end
    else
      conn |> put_flash(:error, "Don't be evil.") |> redirect(to: "/") |> halt
    end
  end

  def delete(conn, %{"id" => id}) do
    needs = Repo.get!(Needs, id)

    if needs.owner_id == current_uid(conn) do
      # Here we use delete! (with a bang) because we expect
      # it to always work (and if it does not, it will raise).
      Repo.delete!(needs)

      conn
      |> put_flash(:info, "Need deleted successfully.")
      |> redirect(to: needs_path(conn, :index))
    else
      conn |> put_flash(:error, "Don't be evil.") |> redirect(to: "/") |> halt
    end
  end

  def current_uid(conn) do
    uid = Plug.Conn.get_session(conn, :current_user)
    if uid do
      Budgetparty.Repo.get(User, uid).email
    end
  end
end
