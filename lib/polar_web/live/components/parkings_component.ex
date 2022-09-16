defmodule PolarWeb.ParkingsComponent do
  use PolarWeb, :live_component

  alias Polar.Parkings.Parking

  def render(assigns) do
    ~H"""
    <div>
      <h3>Parkings</h3>
      <div class="flex justify-around">
        <%= for parking <- @parkings do %>
          <div  id={"parking-#{parking.id}"}
                phx-click="parking-was-selected"
                phx-value-id={parking.id}>
            <%= button_link_body(parking,
                if(is_nil(@selected_item), do: 0, else: @selected_item.id)) %>
          </div>
        <% end %>
      </div>
    </div>
    """
  end

  # this is the parking button styled content
  defp button_link_body(parking, selected_id) do
    default_attr = " hover:bg-blue-300
                    active:bg-blue-400
                    focus:outline-none
                    focus:ring
                    focus:ring-blue-300
                    border
                    rounded-t-lg
                    cursor-pointer
                    p-3"

    btn_attr =
      case parking.id do
        ^selected_id -> "active border-2 border-indigo-400 bg-blue-200 shadow-xl"
        _ -> "border-blue-300 bg-blue-100 shadow-md"
      end

    assigns = %{
      parking: parking,
      btn_attr: btn_attr <> default_attr
    }

    # #{@active} hover:bg-violet-600 active:bg-violet-700 focus:outline-none focus:ring focus:ring-violet-300 relative flex flow-col justify-start space-x-2 p-3 bg-blue-100 rounded-r-lg border-l-4 border-l-blue-300 shadow-md"
    ~H"""
    <div class={@btn_attr}>
      <div class="float-left"><%= get_icons(@parking) %></div>
      <div class="text-gl font-semibold"><%= @parking.name %> </div>
    </div>
    """
  end

  defp get_icons(%Parking{is_free: is_free, has_charger: has_charger}) do
    {free_icon, free_color} =
      case is_free do
        true -> {"check-circle", "text-green-600 bg-green-200 rounded-full"}
        false -> {"x-circle", "text-red-700 bg-red-300 rounded-full"}
      end

    {charger_icon, charger_color} =
      case has_charger do
        true -> {"bolt", "text-gray-600 "}
        false -> {"bolt-slash", "text-gray-400"}
      end

    assigns = %{
      free_icon: free_icon,
      free_color: free_color,
      charger_icon: charger_icon,
      charger_color: charger_color
    }

    ~H"""
      <Heroicons.LiveView.icon name={@free_icon} type="outline" class={"float-left h-5 w-5 #{@free_color}"} />
      <Heroicons.LiveView.icon name={@charger_icon} type="outline" class={"h-5 w-5 #{@charger_color}"} />
    """
  end
end
