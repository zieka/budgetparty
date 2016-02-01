defmodule Budgetparty.NeedsController do
  use Budgetparty.Web, :controller

  alias Budgetparty.User
  alias Budgetparty.Needs

  plug :scrub_params, "needs" when action in [:create, :update]

  def index(conn, _params) do
    uid = Plug.Conn.get_session(conn, :current_user)
    if uid do
      user_email = Budgetparty.Repo.get(User, uid).email
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

    uid = Plug.Conn.get_session(conn, :current_user)
    if uid do
      user_email = Budgetparty.Repo.get(User, uid).email
    end

    if changeset.changes.owner_id == user_email do
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

    uid = Plug.Conn.get_session(conn, :current_user)
    if uid do
      user_email = Budgetparty.Repo.get(User, uid).email
    end

    if needs.owner_id == user_email do
      render(conn, "show.html", needs: needs)
    else
       conn |> put_flash(:error, "Don't be evil.") |> redirect(to: "/") |> halt
    end
  end

  def edit(conn, %{"id" => id}) do
    needs = Repo.get!(Needs, id)
    changeset = Needs.changeset(needs)

    uid = Plug.Conn.get_session(conn, :current_user)
    if uid do
      user_email = Budgetparty.Repo.get(User, uid).email
    end

    if needs.owner_id == user_email do
      render(conn, "edit.html", needs: needs, changeset: changeset)
    else
       conn |> put_flash(:error, "Don't be evil.") |> redirect(to: "/") |> halt
    end
  end

  def update(conn, %{"id" => id, "needs" => needs_params}) do
    needs = Repo.get!(Needs, id)
    changeset = Needs.changeset(needs, needs_params)

    uid = Plug.Conn.get_session(conn, :current_user)
    if uid do
      user_email = Budgetparty.Repo.get(User, uid).email
    end

    if changeset.changes.owner_id == user_email do

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

    uid = Plug.Conn.get_session(conn, :current_user)
    if uid do
      user_email = Budgetparty.Repo.get(User, uid).email
    end


    if needs.owner_id == user_email do
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
end
