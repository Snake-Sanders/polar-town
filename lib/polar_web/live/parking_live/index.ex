defmodule PolarWeb.ParkingLive.Index do
  use PolarWeb, :live_view

  alias Polar.Parkings
  alias Polar.Parkings.Parking

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :parkings, list_parkings())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Parking")
    |> assign(:parking, Parkings.get_parking!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Parking")
    |> assign(:parking, %Parking{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Parkings")
    |> assign(:parking, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    parking = Parkings.get_parking!(id)
    {:ok, _} = Parkings.delete_parking(parking)

    {:noreply, assign(socket, :parkings, list_parkings())}
  end

  def handle_event("delete-all", _params, socket) do
    Parkings.delete_all_parkings()
    {:noreply, assign(socket, :parkings, list_parkings())}
  end

  def handle_event("auto-gen", _params, socket) do
    Parkings.gen_random_parkings(6)
    {:noreply, assign(socket, :parkings, list_parkings())}
  end

  defp list_parkings do
    Parkings.list_parkings()
  end
end
