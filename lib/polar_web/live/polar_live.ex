defmodule PolarWeb.PolarLive do
  use PolarWeb, :live_view

  def mount(_param, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1 class="text-4x1 text-xl font-bold text-center text-blue-800">Polar Services</h1>
    <!-- <div class="flex flex-row items-stretch"> -->
    <div class="flex justify-around mt-6">
      <div class="p-3 bg-indigo-500 hover:bg-indigo-600 active:bg-violet-700 focus:outline-none focus:ring focus:ring-violet-300 shadow-lg shadow-indigo-800/50 font-semibold text-gray-200 rounded-lg">
      </div>
      <div class="p-3 bg-indigo-500 hover:bg-indigo-600 active:bg-violet-700 focus:outline-none focus:ring focus:ring-violet-300 shadow-lg shadow-indigo-800/50 font-semibold text-gray-200 rounded-lg">
        <%= live_redirect("Parking", to: Routes.live_path(@socket, PolarWeb.ParkingLive)) %>
      </div>
      <div class="p-3 bg-indigo-500 hover:bg-indigo-600 shadow-lg shadow-indigo-800/50 font-semibold text-gray-200 rounded-lg">Parking</div>
      <div class="p-3 bg-indigo-500 hover:bg-indigo-600 shadow-lg shadow-indigo-800/50 font-semibold text-gray-200 rounded-lg">Sauna</div>
    </div>
    """
  end
end
