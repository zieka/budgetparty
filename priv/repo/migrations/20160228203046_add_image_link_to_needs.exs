defmodule Budgetparty.Repo.Migrations.AddImageLinkToNeeds do
  use Ecto.Migration

  def change do
    alter table(:needs) do
      add :img_url, :string
    end
  end
end
