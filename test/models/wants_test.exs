defmodule Budgetparty.WantsTest do
  use Budgetparty.ModelCase

  alias Budgetparty.Wants

  @valid_attrs %{description: "some content", financial_cost: "some content", frequency: "some content", link: "some content", time_cost: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Wants.changeset(%Wants{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Wants.changeset(%Wants{}, @invalid_attrs)
    refute changeset.valid?
  end
end
