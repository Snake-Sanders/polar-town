defmodule PolarWeb.UserAuthLive do
  import Phoenix.LiveView

  alias Polar.Accounts

  def on_mount(_, _paramas, %{"user_token" => user_token}, socket) do
    # When a LiveView is mounted in a disconnected state, the Plug.Conn
    # assigns will be available for reference via assign_new/3, allowing
    # assigns to be shared for the initial HTTP request.

    socket =
      assign_new(socket, :current_user,
          fn -> Accounts.get_user_by_session_token(user_token) end
        )

    # if the user was found in the DB or it was already logged in, then continue
    if socket.assigns.current_user do
      {:cont, socket}
    else
      {:halt, redirect(socket, to: "/login")}
    end
  end

  def on_mount(_, _paramas, _, socket) do
    {:halt, redirect(socket, to: "/login")}
  end
end
