defmodule PolarWeb.PolarLive do
  use PolarWeb, :live_view

  alias Polar.Parkings

  def mount(_param, _session, socket) do
    socket =
      assign(socket,
        parkings: Parkings.list_parkings(),
        selected_item: nil
      )

    {:ok, socket}
  end

  def handle_event("parking-was-selected", %{"id" => parking_id}, socket) do
    # 1. update selected item within the socket
    # 2. re-render the view
    # 3. update the url with selected id
    # 4. update the map with selected marker

    parking = find_parking(socket, String.to_integer(parking_id))

    socket =
      socket
      |> assign(selected_item: parking)
      |> push_event("highlight-marker", parking)

    {:noreply, socket}
  end

  def handle_event("get-geoassets", _params, socket) do
    # triggered when the client first connect over the websocket
    # the client requests the list of markers from the server

    {:reply, %{geoassets: socket.assigns.parkings}, socket}
  end

  def handle_event("marker-clicked", parking_id, socket) do
    # triggered when a pin is selected on the map

    selected_item = find_parking(socket, parking_id)
    socket = assign(socket, selected_item: selected_item)
    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <h1 class="text-center">Polar Services</h1>

    <div class="flex justify-around mt-6">
      <div>
        <%= live_redirect("Admin Parkings", to: "/parkings", class: "button") %>
      </div>
    </div>
    <.live_component module={PolarWeb.ParkingsComponent}
                    id="parking-list"
                    parkings={@parkings}
                    selected_item={@selected_item}/>

    <div id="map-wrapper" phx-update="ignore" class="pt-16">
      <div id="map"
        phx-hook="PhxHookGeoAssetMap">
      </div>
    </div>
    """
  end

  defp find_parking(socket, parking_id) do
    Enum.find(socket.assigns.parkings, fn p -> p.id == parking_id end)
  end
end
