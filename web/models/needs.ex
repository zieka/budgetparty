defmodule Budgetparty.Needs do
  use Budgetparty.Web, :model

  schema "needs" do
    field :title, :string
    field :description, :string
    field :link, :string
    field :time_cost, :float, default: 0.00
    field :financial_cost, :float, default: 0.00
    field :frequency, :string
    field :owner_id, :string

    timestamps
  end

  @required_fields ~w(title time_cost financial_cost frequency owner_id)
  @optional_fields ~w(description link)

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
