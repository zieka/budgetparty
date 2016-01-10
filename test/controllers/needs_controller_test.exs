defmodule Budgetparty.NeedsControllerTest do
  use Budgetparty.ConnCase

  alias Budgetparty.Needs
  @valid_attrs %{description: "some content", financial_cost: "some content", frequency: "some content", link: "some content", time_cost: "some content", title: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, needs_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing needs"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, needs_path(conn, :new)
    assert html_response(conn, 200) =~ "New needs"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, needs_path(conn, :create), needs: @valid_attrs
    assert redirected_to(conn) == needs_path(conn, :index)
    assert Repo.get_by(Needs, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, needs_path(conn, :create), needs: @invalid_attrs
    assert html_response(conn, 200) =~ "New needs"
  end

  test "shows chosen resource", %{conn: conn} do
    needs = Repo.insert! %Needs{}
    conn = get conn, needs_path(conn, :show, needs)
    assert html_response(conn, 200) =~ "Show needs"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, needs_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    needs = Repo.insert! %Needs{}
    conn = get conn, needs_path(conn, :edit, needs)
    assert html_response(conn, 200) =~ "Edit needs"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    needs = Repo.insert! %Needs{}
    conn = put conn, needs_path(conn, :update, needs), needs: @valid_attrs
    assert redirected_to(conn) == needs_path(conn, :show, needs)
    assert Repo.get_by(Needs, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    needs = Repo.insert! %Needs{}
    conn = put conn, needs_path(conn, :update, needs), needs: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit needs"
  end

  test "deletes chosen resource", %{conn: conn} do
    needs = Repo.insert! %Needs{}
    conn = delete conn, needs_path(conn, :delete, needs)
    assert redirected_to(conn) == needs_path(conn, :index)
    refute Repo.get(Needs, needs.id)
  end
end
