defmodule PolarWeb.ParkingReservationLiveTest do
  use PolarWeb.ConnCase

  import Phoenix.LiveViewTest
  import Polar.ReservationsFixtures

  @create_attrs %{time_end: %{day: 16, hour: 17, minute: 28, month: 9, year: 2022}, time_start: %{day: 16, hour: 17, minute: 28, month: 9, year: 2022}}
  @update_attrs %{time_end: %{day: 17, hour: 17, minute: 28, month: 9, year: 2022}, time_start: %{day: 17, hour: 17, minute: 28, month: 9, year: 2022}}
  @invalid_attrs %{time_end: %{day: 30, hour: 17, minute: 28, month: 2, year: 2022}, time_start: %{day: 30, hour: 17, minute: 28, month: 2, year: 2022}}

  defp create_parking_reservation(_) do
    parking_reservation = parking_reservation_fixture()
    %{parking_reservation: parking_reservation}
  end

  describe "Index" do
    setup [:create_parking_reservation]

    test "lists all parking_reservations", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, Routes.parking_reservation_index_path(conn, :index))

      assert html =~ "Listing Parking reservations"
    end

    test "saves new parking_reservation", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.parking_reservation_index_path(conn, :index))

      assert index_live |> element("a", "New Parking reservation") |> render_click() =~
               "New Parking reservation"

      assert_patch(index_live, Routes.parking_reservation_index_path(conn, :new))

      assert index_live
             |> form("#parking_reservation-form", parking_reservation: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#parking_reservation-form", parking_reservation: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.parking_reservation_index_path(conn, :index))

      assert html =~ "Parking reservation created successfully"
    end

    test "updates parking_reservation in listing", %{conn: conn, parking_reservation: parking_reservation} do
      {:ok, index_live, _html} = live(conn, Routes.parking_reservation_index_path(conn, :index))

      assert index_live |> element("#parking_reservation-#{parking_reservation.id} a", "Edit") |> render_click() =~
               "Edit Parking reservation"

      assert_patch(index_live, Routes.parking_reservation_index_path(conn, :edit, parking_reservation))

      assert index_live
             |> form("#parking_reservation-form", parking_reservation: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#parking_reservation-form", parking_reservation: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.parking_reservation_index_path(conn, :index))

      assert html =~ "Parking reservation updated successfully"
    end

    test "deletes parking_reservation in listing", %{conn: conn, parking_reservation: parking_reservation} do
      {:ok, index_live, _html} = live(conn, Routes.parking_reservation_index_path(conn, :index))

      assert index_live |> element("#parking_reservation-#{parking_reservation.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#parking_reservation-#{parking_reservation.id}")
    end
  end

  describe "Show" do
    setup [:create_parking_reservation]

    test "displays parking_reservation", %{conn: conn, parking_reservation: parking_reservation} do
      {:ok, _show_live, html} = live(conn, Routes.parking_reservation_show_path(conn, :show, parking_reservation))

      assert html =~ "Show Parking reservation"
    end

    test "updates parking_reservation within modal", %{conn: conn, parking_reservation: parking_reservation} do
      {:ok, show_live, _html} = live(conn, Routes.parking_reservation_show_path(conn, :show, parking_reservation))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Parking reservation"

      assert_patch(show_live, Routes.parking_reservation_show_path(conn, :edit, parking_reservation))

      assert show_live
             |> form("#parking_reservation-form", parking_reservation: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        show_live
        |> form("#parking_reservation-form", parking_reservation: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.parking_reservation_show_path(conn, :show, parking_reservation))

      assert html =~ "Parking reservation updated successfully"
    end
  end
end
