defmodule PolarWeb.ParkingLiveTest do
  use PolarWeb.ConnCase

  import Phoenix.LiveViewTest
  import Polar.ParkingsFixtures

  @create_attrs %{has_charger: true, is_free: true, name: "some name"}
  @update_attrs %{has_charger: false, is_free: false, name: "some updated name"}
  @invalid_attrs %{has_charger: false, is_free: false, name: nil}

  defp create_parking(_) do
    parking = parking_fixture()
    %{parking: parking}
  end

  describe "Index" do
    setup [:create_parking]

    test "lists all parkings", %{conn: conn, parking: parking} do
      {:ok, _index_live, html} = live(conn, Routes.parking_index_path(conn, :index))

      assert html =~ "Listing Parkings"
      assert html =~ parking.name
    end

    test "saves new parking", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.parking_index_path(conn, :index))

      assert index_live |> element("a", "New Parking") |> render_click() =~
               "New Parking"

      assert_patch(index_live, Routes.parking_index_path(conn, :new))

      assert index_live
             |> form("#parking-form", parking: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#parking-form", parking: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.parking_index_path(conn, :index))

      assert html =~ "Parking created successfully"
      assert html =~ "some name"
    end

    test "updates parking in listing", %{conn: conn, parking: parking} do
      {:ok, index_live, _html} = live(conn, Routes.parking_index_path(conn, :index))

      assert index_live |> element("#parking-#{parking.id} a", "Edit") |> render_click() =~
               "Edit Parking"

      assert_patch(index_live, Routes.parking_index_path(conn, :edit, parking))

      assert index_live
             |> form("#parking-form", parking: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#parking-form", parking: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.parking_index_path(conn, :index))

      assert html =~ "Parking updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes parking in listing", %{conn: conn, parking: parking} do
      {:ok, index_live, _html} = live(conn, Routes.parking_index_path(conn, :index))

      assert index_live |> element("#parking-#{parking.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#parking-#{parking.id}")
    end
  end

  describe "Show" do
    setup [:create_parking]

    test "displays parking", %{conn: conn, parking: parking} do
      {:ok, _show_live, html} = live(conn, Routes.parking_show_path(conn, :show, parking))

      assert html =~ "Show Parking"
      assert html =~ parking.name
    end

    test "updates parking within modal", %{conn: conn, parking: parking} do
      {:ok, show_live, _html} = live(conn, Routes.parking_show_path(conn, :show, parking))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Parking"

      assert_patch(show_live, Routes.parking_show_path(conn, :edit, parking))

      assert show_live
             |> form("#parking-form", parking: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#parking-form", parking: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.parking_show_path(conn, :show, parking))

      assert html =~ "Parking updated successfully"
      assert html =~ "some updated name"
    end
  end
end
