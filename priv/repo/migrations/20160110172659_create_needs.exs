defmodule Budgetparty.Repo.Migrations.CreateNeeds do
  use Ecto.Migration

  def change do
    create table(:needs) do
      add :title, :string
      add :description, :text
      add :link, :string
      add :time_cost, :string
      add :financial_cost, :string
      add :frequency, :string

      timestamps
    end

  end
end
