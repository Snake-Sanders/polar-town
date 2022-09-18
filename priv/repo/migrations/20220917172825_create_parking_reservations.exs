defmodule Polar.Repo.Migrations.CreateParkingReservations do

  # mix phx.gen.live Reservations ParkingReservation parking_reservations parking_id:references:parkings user_id:references:users time_start:naive_datetime time_end:naive_datetime

  use Ecto.Migration

  def change do
    create table(:parking_reservations) do
      add :time_start, :naive_datetime
      add :time_end, :naive_datetime
      add :parking_id, references(:parkings, on_delete: :delete_all)
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:parking_reservations, [:parking_id])
    create index(:parking_reservations, [:user_id])
  end
end
