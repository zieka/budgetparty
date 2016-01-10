defmodule Budgetparty.WantsController do
  use Budgetparty.Web, :controller

  alias Budgetparty.Wants

  plug :scrub_params, "wants" when action in [:create, :update]

  def index(conn, _params) do
    wants = Repo.all(Wants)
    render(conn, "index.html", wants: wants)
  end

  def new(conn, _params) do
    changeset = Wants.changeset(%Wants{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"wants" => wants_params}) do
    changeset = Wants.changeset(%Wants{}, wants_params)

    case Repo.insert(changeset) do
      {:ok, _wants} ->
        conn
        |> put_flash(:info, "Wants created successfully.")
        |> redirect(to: wants_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    wants = Repo.get!(Wants, id)
    render(conn, "show.html", wants: wants)
  end

  def edit(conn, %{"id" => id}) do
    wants = Repo.get!(Wants, id)
    changeset = Wants.changeset(wants)
    render(conn, "edit.html", wants: wants, changeset: changeset)
  end

  def update(conn, %{"id" => id, "wants" => wants_params}) do
    wants = Repo.get!(Wants, id)
    changeset = Wants.changeset(wants, wants_params)

    case Repo.update(changeset) do
      {:ok, wants} ->
        conn
        |> put_flash(:info, "Wants updated successfully.")
        |> redirect(to: wants_path(conn, :show, wants))
      {:error, changeset} ->
        render(conn, "edit.html", wants: wants, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    wants = Repo.get!(Wants, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(wants)

    conn
    |> put_flash(:info, "Wants deleted successfully.")
    |> redirect(to: wants_path(conn, :index))
  end
end
