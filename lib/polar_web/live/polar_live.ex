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
      <div class="bg-blue-200 p-3 font-bold text-indigo-800 rounded-tr-lg">Vehicle</div>
      <div class="bg-blue-200 p-3 font-bold text-indigo-800 rounded-tr-lg">Parking</div>
      <div class="bg-blue-200 p-3 font-bold text-indigo-800 rounded-tr-lg">Sauna</div>
    </div>
    """
  end
end
