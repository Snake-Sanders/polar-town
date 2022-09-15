defmodule Polar.Repo.Migrations.AddLocationToParkings do
  use Ecto.Migration

  # Note:
  # To modify an existing table just create the migration and manually edit it.
  #   mix ecto.gen.migration add_location_to_parkings
  # Then use `alter table`
  # https://hexdocs.pm/ecto_sql/3.8.1/Ecto.Migration.html#alter/2
  #
  # Then do:
  # 1 - update the parking.ex schema
  # 2 - update the changeset to cast the new attributes
  # 3 - update the Create/Edit forms
  def change do
    alter table("parkings") do
      add :lat, :float, default: 0.0
      add :lng, :float, default: 0.0
    end
  end
end
