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

  # TODO: this event should be handled by the component
  # handle_event("date-picked", %{"start" => "2022-09-20T22:00:00.000Z"}
  def handle_event("date-picked", %{"start" => start_time}, socket) do

    start_ndt = NaiveDateTime.from_iso8601!(start_time)
    socket = update(socket, :time_start, fn _ -> start_ndt end)

    {:noreply, socket}
  end
  defp list_parking_reservations do
    Reservations.list_parking_reservations()
  end
end
