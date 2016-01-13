defmodule Budgetparty.Repo.Migrations.AddFieldsToNeeds do
  use Ecto.Migration

  def change do
  	alter table(:needs) do
  		remove :time_cost
  		remove :financial_cost
      add :time_cost, :float
      add :financial_cost, :float
      add :owner_id, :string
    end
  end
end
