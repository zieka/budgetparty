defmodule Budgetparty.NeedsTest do
  use Budgetparty.ModelCase

  alias Budgetparty.Needs

  @valid_attrs %{description: "some content", financial_cost: "some content", frequency: "some content", link: "some content", time_cost: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Needs.changeset(%Needs{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Needs.changeset(%Needs{}, @invalid_attrs)
    refute changeset.valid?
  end
end
