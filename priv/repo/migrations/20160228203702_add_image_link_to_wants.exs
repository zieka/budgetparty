defmodule Budgetparty.Repo.Migrations.AddImageLinkToWants do
  use Ecto.Migration

  def change do
    alter table(:wants) do
      add :img_url, :string
    end
  end
end
