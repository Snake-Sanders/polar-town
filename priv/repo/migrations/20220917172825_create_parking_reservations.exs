defmodule Polar.Repo.Migrations.CreateParkingReservations do
  use Ecto.Migration

  def change do
    create table(:parking_reservations) do
      add :time_start, :naive_datetime
      add :time_end, :naive_datetime
      add :parking_id, references(:parkings, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:parking_reservations, [:parking_id])
    create index(:parking_reservations, [:user_id])
  end
end
