defmodule PolarWeb.PolarLive do
  use PolarWeb, :live_view

  alias Polar.Parkings
  alias Polar.Parkings.Parking

  def mount(_param, _session, socket) do
    socket = assign(socket, parkings: Parkings.list_parkings())

    {:ok, socket}
  end

  def handle_params(%{"id" => parking_id}, _url, socket) do
    parking = Parkings.get_parking!(parking_id)
    socket = assign(socket, selected_item: parking)
    {:noreply, socket}
  end

  def handle_params(_, _url, socket) do
    socket = assign(socket, selected_item: nil)
    {:noreply, socket}
  end

  def handle_event("get-geoassets", _session, socket) do
    {:reply, %{geoassets: socket.assigns.parkings}, socket}
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
end
