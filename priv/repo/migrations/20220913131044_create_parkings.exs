defmodule Polar.Repo.Migrations.CreateParkings do
  use Ecto.Migration

  def change do
    create table(:parkings) do
      add :name, :string
      add :is_free, :boolean, default: false, null: false
      add :has_charger, :boolean, default: false, null: false

      timestamps()
    end
  end
end
