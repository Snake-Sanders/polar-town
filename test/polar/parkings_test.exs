defmodule Polar.ParkingsTest do
  use Polar.DataCase

  alias Polar.Parkings

  describe "parkings" do
    alias Polar.Parkings.Parking

    import Polar.ParkingsFixtures

    @invalid_attrs %{has_charger: nil, is_free: nil, name: nil}

    test "list_parkings/0 returns all parkings" do
      parking = parking_fixture()
      assert Parkings.list_parkings() == [parking]
    end

    test "get_parking!/1 returns the parking with given id" do
      parking = parking_fixture()
      assert Parkings.get_parking!(parking.id) == parking
    end

    test "create_parking/1 with valid data creates a parking" do
      valid_attrs = %{has_charger: true, is_free: true, name: "some name"}

      assert {:ok, %Parking{} = parking} = Parkings.create_parking(valid_attrs)
      assert parking.has_charger == true
      assert parking.is_free == true
      assert parking.name == "some name"
    end

    test "create_parking/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Parkings.create_parking(@invalid_attrs)
    end

    test "update_parking/2 with valid data updates the parking" do
      parking = parking_fixture()
      update_attrs = %{has_charger: false, is_free: false, name: "some updated name"}

      assert {:ok, %Parking{} = parking} = Parkings.update_parking(parking, update_attrs)
      assert parking.has_charger == false
      assert parking.is_free == false
      assert parking.name == "some updated name"
    end

    test "update_parking/2 with invalid data returns error changeset" do
      parking = parking_fixture()
      assert {:error, %Ecto.Changeset{}} = Parkings.update_parking(parking, @invalid_attrs)
      assert parking == Parkings.get_parking!(parking.id)
    end

    test "delete_parking/1 deletes the parking" do
      parking = parking_fixture()
      assert {:ok, %Parking{}} = Parkings.delete_parking(parking)
      assert_raise Ecto.NoResultsError, fn -> Parkings.get_parking!(parking.id) end
    end

    test "change_parking/1 returns a parking changeset" do
      parking = parking_fixture()
      assert %Ecto.Changeset{} = Parkings.change_parking(parking)
    end
  end
end
