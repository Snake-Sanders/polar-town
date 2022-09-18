defmodule Polar.Reservations.ParkingReservation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "parking_reservations" do
    field :time_end, :naive_datetime
    field :time_start, :naive_datetime

    belongs_to :parking, Polar.Parkings.Parking
    belongs_to :user, Polar.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(parking_reservation, attrs) do
    parking_reservation
    |> cast(attrs, [:time_start, :time_end])
    |> validate_required([:time_start, :time_end])
  end
end
