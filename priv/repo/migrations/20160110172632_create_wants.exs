defmodule Budgetparty.Repo.Migrations.CreateWants do
  use Ecto.Migration

  def change do
    create table(:wants) do
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
