defmodule Polar.Reservations do
  @moduledoc """
  The Reservations context.
  """

  import Ecto.Query, warn: false
  alias Polar.Repo

  alias Polar.Reservations.ParkingReservation

  @doc """
  Returns the list of parking_reservations.

  ## Examples

      iex> list_parking_reservations()
      [%ParkingReservation{}, ...]

  """
  def list_parking_reservations do
    Repo.all(ParkingReservation)
  end

  @doc """
  Gets a single parking_reservation.

  Raises `Ecto.NoResultsError` if the Parking reservation does not exist.

  ## Examples

      iex> get_parking_reservation!(123)
      %ParkingReservation{}

      iex> get_parking_reservation!(456)
      ** (Ecto.NoResultsError)

  """
  def get_parking_reservation!(id), do: Repo.get!(ParkingReservation, id)

  @doc """
  Creates a parking_reservation.

  ## Examples

      iex> create_parking_reservation(%{field: value})
      {:ok, %ParkingReservation{}}

      iex> create_parking_reservation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_parking_reservation(attrs \\ %{}) do
    %ParkingReservation{}
    |> ParkingReservation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a parking_reservation.

  ## Examples

      iex> update_parking_reservation(parking_reservation, %{field: new_value})
      {:ok, %ParkingReservation{}}

      iex> update_parking_reservation(parking_reservation, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_parking_reservation(%ParkingReservation{} = parking_reservation, attrs) do
    parking_reservation
    |> ParkingReservation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a parking_reservation.

  ## Examples

      iex> delete_parking_reservation(parking_reservation)
      {:ok, %ParkingReservation{}}

      iex> delete_parking_reservation(parking_reservation)
      {:error, %Ecto.Changeset{}}

  """
  def delete_parking_reservation(%ParkingReservation{} = parking_reservation) do
    Repo.delete(parking_reservation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking parking_reservation changes.

  ## Examples

      iex> change_parking_reservation(parking_reservation)
      %Ecto.Changeset{data: %ParkingReservation{}}

  """
  def change_parking_reservation(%ParkingReservation{} = parking_reservation, attrs \\ %{}) do
    ParkingReservation.changeset(parking_reservation, attrs)
  end
end
