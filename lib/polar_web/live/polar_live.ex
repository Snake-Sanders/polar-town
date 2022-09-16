defmodule PolarWeb.PolarLive do
  use PolarWeb, :live_view

  alias Polar.Parkings
  alias Polar.Parkings.Parking

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

  def handle_event("dropped-new-marker", %{"lat" => lat, "lng" => lng}, socket) do
    # 1. A new pin was just dropped
    # 2. with the coordinates create a new entry in DB
    # 3. send back the id so it can be linked

    parking = %{name: "new", lat: lat, lng: lng}

    case Parkings.create_parking(parking) do
      {:ok, %Parking{} = new_parking} ->
        socket =
          assign(socket,
            selected_item: new_parking,
            parkings: [new_parking | socket.assigns.parkings]
          )

        {:reply, %{geoasset: new_parking}, socket}

      {:error, %Ecto.Changeset{}} ->
        {:reply, %{geoasset: nil}, socket}
    end
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
    <div class="flex justify-end">
      <%= live_redirect("Admin Parkings", to: "/parkings", class: "button") %>
    </div>

    <div class="mt-6 w-full border border-gray-300 rounded-xl p-2 bg-white">
      <%= if is_nil(@selected_item) do %>
        <p>Select a Parking from the list</p>
      <% else %>
        <div class="flex flex-row space-x-8 p-4 items-center justify-center ">
          <div class="">
            <%= display_parking_info(@selected_item)%>
          </div>

          <div class="">
            <%= live_redirect("Reserve now!", to: "/parkings", class: "button") %>
          </div>
        </div>
      <% end %>
    </div>

    <div class="flex pt-8">

      <div id="map-wrapper" phx-update="ignore" class="grow h-380">
        <div id="map"
          phx-hook="PhxHookGeoAssetMap">
        </div>
      </div>

      <div class="flex-none w-52 ml-4 justify-start ">
      <.live_component module={PolarWeb.ParkingsComponent}
      id="parking-list"
      parkings={@parkings}
      selected_item={@selected_item}/>
      </div>

    </div>
    """
  end

  defp find_parking(socket, parking_id) do
    Enum.find(socket.assigns.parkings, fn p -> p.id == parking_id end)
  end

  defp display_parking_info(parking) do
    assigns = %{parking: parking}

    ~H"""
    <ul>
      <li><h3 class="mt-0">Parking description</h3></li>
      <li><p class="font-semibold">
        Location: <span class="font-normal"><%= @parking.name %></span>
        </p></li>
      <li><p class="font-semibold">
        Electric charger: <span class="font-normal"><%= if @parking.has_charger, do: "Yes", else: "No" %></span>
        </p></li>
      <li><p class="font-semibold">
        Status: <span class="font-normal"><%= if @parking.is_free, do: "Available now", else: "Not available" %></span>
        </p></li>
    </ul>
    """
  end
end
