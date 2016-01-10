defmodule Budgetparty.Wants do
  use Budgetparty.Web, :model

  schema "wants" do
    field :title, :string
    field :description, :string
    field :link, :string
    field :time_cost, :string
    field :financial_cost, :string
    field :frequency, :string

    timestamps
  end

  @required_fields ~w(title description link time_cost financial_cost frequency)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
