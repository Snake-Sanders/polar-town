defmodule PolarWeb.ParkingDisplayComponent do
  use PolarWeb, :live_component

  def render(assigns) do
    ~H"""
    <div class="mt-6 w-full border border-gray-300 rounded-xl p-2 bg-white">
      <%= if is_nil(@selected_item) do %>
        <p>Select a Parking from the list</p>
      <% else %>
        <div class="flex flex-row space-x-8 p-4 items-center justify-center ">
          <div class="">
            <%= display_parking_info(@selected_item)%>
          </div>

          <div class="">
            <%= live_redirect( "Reserve now!",
                to: Routes.parking_reservation_index_path(@socket, :new),
                class: "button") %>
          </div>
        </div>
      <% end %>
    </div>
    """
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
