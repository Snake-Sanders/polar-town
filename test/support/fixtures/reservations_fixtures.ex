defmodule Polar.ReservationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Polar.Reservations` context.
  """

  @doc """
  Generate a parking_reservation.
  """
  def parking_reservation_fixture(attrs \\ %{}) do
    {:ok, parking_reservation} =
      attrs
      |> Enum.into(%{
        time_end: ~N[2022-09-16 17:28:00],
        time_start: ~N[2022-09-16 17:28:00]
      })
      |> Polar.Reservations.create_parking_reservation()

    parking_reservation
  end
end
