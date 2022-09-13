defmodule Polar.ParkingsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Polar.Parkings` context.
  """

  @doc """
  Generate a parking.
  """
  def parking_fixture(attrs \\ %{}) do
    {:ok, parking} =
      attrs
      |> Enum.into(%{
        has_charger: true,
        is_free: true,
        name: "some name"
      })
      |> Polar.Parkings.create_parking()

    parking
  end
end
