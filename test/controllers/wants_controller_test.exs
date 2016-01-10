defmodule Budgetparty.WantsControllerTest do
  use Budgetparty.ConnCase

  alias Budgetparty.Wants
  @valid_attrs %{description: "some content", financial_cost: "some content", frequency: "some content", link: "some content", time_cost: "some content", title: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, wants_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing wants"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, wants_path(conn, :new)
    assert html_response(conn, 200) =~ "New wants"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, wants_path(conn, :create), wants: @valid_attrs
    assert redirected_to(conn) == wants_path(conn, :index)
    assert Repo.get_by(Wants, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, wants_path(conn, :create), wants: @invalid_attrs
    assert html_response(conn, 200) =~ "New wants"
  end

  test "shows chosen resource", %{conn: conn} do
    wants = Repo.insert! %Wants{}
    conn = get conn, wants_path(conn, :show, wants)
    assert html_response(conn, 200) =~ "Show wants"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, wants_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    wants = Repo.insert! %Wants{}
    conn = get conn, wants_path(conn, :edit, wants)
    assert html_response(conn, 200) =~ "Edit wants"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    wants = Repo.insert! %Wants{}
    conn = put conn, wants_path(conn, :update, wants), wants: @valid_attrs
    assert redirected_to(conn) == wants_path(conn, :show, wants)
    assert Repo.get_by(Wants, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    wants = Repo.insert! %Wants{}
    conn = put conn, wants_path(conn, :update, wants), wants: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit wants"
  end

  test "deletes chosen resource", %{conn: conn} do
    wants = Repo.insert! %Wants{}
    conn = delete conn, wants_path(conn, :delete, wants)
    assert redirected_to(conn) == wants_path(conn, :index)
    refute Repo.get(Wants, wants.id)
  end
end
