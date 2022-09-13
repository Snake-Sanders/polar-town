defmodule PolarWeb.PageController do
  use PolarWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
