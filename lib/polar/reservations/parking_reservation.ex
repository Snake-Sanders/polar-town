defmodule Polar.Reservations.ParkingReservation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "parking_reservations" do
    field :time_end, :naive_datetime
    field :time_start, :naive_datetime
    field :parking_id, :id
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(parking_reservation, attrs) do
    parking_reservation
    |> cast(attrs, [:time_start, :time_end])
    |> validate_required([:time_start, :time_end])
  end
end
