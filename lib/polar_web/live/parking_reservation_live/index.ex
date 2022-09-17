defmodule PolarWeb.ParkingReservationLive.Index do
  use PolarWeb, :live_view

  alias Polar.Reservations
  alias Polar.Reservations.ParkingReservation

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :parking_reservations, list_parking_reservations())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Parking reservation")
    |> assign(:parking_reservation, Reservations.get_parking_reservation!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Parking reservation")
    |> assign(:parking_reservation, %ParkingReservation{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Parking reservations")
    |> assign(:parking_reservation, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    parking_reservation = Reservations.get_parking_reservation!(id)
    {:ok, _} = Reservations.delete_parking_reservation(parking_reservation)

    {:noreply, assign(socket, :parking_reservations, list_parking_reservations())}
  end

  defp list_parking_reservations do
    Reservations.list_parking_reservations()
  end
end
