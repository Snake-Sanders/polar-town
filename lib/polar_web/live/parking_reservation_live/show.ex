defmodule PolarWeb.ParkingReservationLive.Show do
  use PolarWeb, :live_view

  alias Polar.Reservations

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:parking_reservation, Reservations.get_parking_reservation!(id))}
  end

  defp page_title(:show), do: "Show Parking reservation"
  defp page_title(:edit), do: "Edit Parking reservation"
end
