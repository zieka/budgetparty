defmodule Budgetparty.Repo.Migrations.AddFieldsToWants do
  use Ecto.Migration

  def change do
  	alter table(:wants) do
  		remove :time_cost
  		remove :financial_cost
      add :time_cost, :float
      add :financial_cost, :float
      add :owner_id, :string
    end
  end
end
