defmodule Budgetparty.WantsController do
  use Budgetparty.Web, :controller

  alias Budgetparty.User
  alias Budgetparty.Wants

  plug :scrub_params, "wants" when action in [:create, :update]

  def index(conn, _params) do
    user_email = current_uid(conn)
    query = from(w in Wants, where: w.owner_id == ^user_email)

    wants = Repo.all(query)
    render(conn, "index.html", wants: wants)
  end

  def new(conn, _params) do
    changeset = Wants.changeset(%Wants{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"wants" => wants_params}) do
    changeset = Wants.changeset(%Wants{}, wants_params)

    if changeset.changes.owner_id == current_uid(conn) do
      case Repo.insert(changeset) do
        {:ok, _wants} ->
          conn
          |> put_flash(:info, "Wants created successfully.")
          |> redirect(to: wants_path(conn, :index))
        {:error, changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    else
      conn |> put_flash(:error, "Don't be evil.") |> redirect(to: "/") |> halt
    end
  end

  def show(conn, %{"id" => id}) do
    wants = Repo.get!(Wants, id)

    if wants.owner_id == current_uid(conn) do
      render(conn, "show.html", wants: wants)
    else
      conn |> put_flash(:error, "Don't be evil.") |> redirect(to: "/") |> halt
    end
  end

  def edit(conn, %{"id" => id}) do
    wants = Repo.get!(Wants, id)
    changeset = Wants.changeset(wants)

    if wants.owner_id == current_uid(conn) do
      render(conn, "edit.html", wants: wants, changeset: changeset)
    else
      conn |> put_flash(:error, "Don't be evil.") |> redirect(to: "/") |> halt
    end
  end

  def update(conn, %{"id" => id, "wants" => wants_params}) do
    wants = Repo.get!(Wants, id)

    if wants.owner_id == current_uid(conn) do

      changeset = Wants.changeset(wants, wants_params)
      case Repo.update(changeset) do
        {:ok, wants} ->
          conn
          |> put_flash(:info, "Want updated successfully.")
          |> redirect(to: wants_path(conn, :show, wants))
        {:error, changeset} ->
          render(conn, "edit.html", wants: wants, changeset: changeset)
      end
    else
      conn |> put_flash(:error, "Don't be evil.") |> redirect(to: "/") |> halt
    end
  end

  def delete(conn, %{"id" => id}) do
    wants = Repo.get!(Wants, id)

    if wants.owner_id == current_uid(conn) do
      # Here we use delete! (with a bang) because we expect
      # it to always work (and if it does not, it will raise).
      Repo.delete!(wants)

      conn
      |> put_flash(:info, "Want deleted successfully.")
      |> redirect(to: wants_path(conn, :index))
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
