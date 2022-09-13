defmodule PolarWeb.PolarLive do
  use PolarWeb, :live_view

  def mount(_param, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1 class="text-4x1 font-bold text-center text-indigo-600">Polar</h1>
    """
  end
end
