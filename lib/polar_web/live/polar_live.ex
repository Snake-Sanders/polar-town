defmodule PolarWeb.PolarLive do
  use PolarWeb, :live_view

  alias Polar.Parkings
  alias Polar.Parkings.Parking

  def mount(_param, _session, socket) do
    socket = assign(socket, parkings: Parkings.list_parkings())

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1 class="text-center">Polar Services</h1>
    <!-- <div class="flex flex-row items-stretch"> -->
    <div class="flex justify-around mt-6">
      <!-- "p-3 bg-indigo-500 hover:bg-indigo-600 active:bg-violet-700 focus:outline-none focus:ring focus:ring-violet-300 shadow-lg shadow-indigo-800/50 font-semibold text-gray-200 rounded-lg" -->
      <div>
      <%= live_redirect("Admin Parkings", to: "/parkings", class: "button") %>
      </div>
    </div>

    <div>
      <h3>Parkings</h3>
      <div class="grid grid-cols-4 gap-8">
      <%= for p <- @parkings do %>
        <div class="flex flex-row justify-around">
          <div class="relative flex flow-col justify-start space-x-2 p-3 bg-blue-100 rounded-r-lg border-l-4 border-l-blue-300 shadow-md">
            <div class="text-gl font-semibold pr-8"><%= p.name %> </div>
            <div class="absolute top-1 right-1">
              <%= get_icons(p) %>
            </div>
          </div>
        </div>
      <% end %>
      </div>
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
    <div>
      <Heroicons.LiveView.icon name={@free_icon} type="outline" class={"h-5 w-5 #{@free_color}"} />
    </div>
    <div>
      <Heroicons.LiveView.icon name={@charger_icon} type="outline" class={"h-5 w-5 #{@charger_color}"} />
    </div>
    """
  end
end
