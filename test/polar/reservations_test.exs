defmodule Polar.ReservationsTest do
  use Polar.DataCase

  alias Polar.Reservations

  describe "parking_reservations" do
    alias Polar.Reservations.ParkingReservation

    import Polar.ReservationsFixtures

    @invalid_attrs %{time_end: nil, time_start: nil}

    test "list_parking_reservations/0 returns all parking_reservations" do
      parking_reservation = parking_reservation_fixture()
      assert Reservations.list_parking_reservations() == [parking_reservation]
    end

    test "get_parking_reservation!/1 returns the parking_reservation with given id" do
      parking_reservation = parking_reservation_fixture()
      assert Reservations.get_parking_reservation!(parking_reservation.id) == parking_reservation
    end

    test "create_parking_reservation/1 with valid data creates a parking_reservation" do
      valid_attrs = %{time_end: ~N[2022-09-16 17:28:00], time_start: ~N[2022-09-16 17:28:00]}

      assert {:ok, %ParkingReservation{} = parking_reservation} = Reservations.create_parking_reservation(valid_attrs)
      assert parking_reservation.time_end == ~N[2022-09-16 17:28:00]
      assert parking_reservation.time_start == ~N[2022-09-16 17:28:00]
    end

    test "create_parking_reservation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Reservations.create_parking_reservation(@invalid_attrs)
    end

    test "update_parking_reservation/2 with valid data updates the parking_reservation" do
      parking_reservation = parking_reservation_fixture()
      update_attrs = %{time_end: ~N[2022-09-17 17:28:00], time_start: ~N[2022-09-17 17:28:00]}

      assert {:ok, %ParkingReservation{} = parking_reservation} = Reservations.update_parking_reservation(parking_reservation, update_attrs)
      assert parking_reservation.time_end == ~N[2022-09-17 17:28:00]
      assert parking_reservation.time_start == ~N[2022-09-17 17:28:00]
    end

    test "update_parking_reservation/2 with invalid data returns error changeset" do
      parking_reservation = parking_reservation_fixture()
      assert {:error, %Ecto.Changeset{}} = Reservations.update_parking_reservation(parking_reservation, @invalid_attrs)
      assert parking_reservation == Reservations.get_parking_reservation!(parking_reservation.id)
    end

    test "delete_parking_reservation/1 deletes the parking_reservation" do
      parking_reservation = parking_reservation_fixture()
      assert {:ok, %ParkingReservation{}} = Reservations.delete_parking_reservation(parking_reservation)
      assert_raise Ecto.NoResultsError, fn -> Reservations.get_parking_reservation!(parking_reservation.id) end
    end

    test "change_parking_reservation/1 returns a parking_reservation changeset" do
      parking_reservation = parking_reservation_fixture()
      assert %Ecto.Changeset{} = Reservations.change_parking_reservation(parking_reservation)
    end
  end
end
