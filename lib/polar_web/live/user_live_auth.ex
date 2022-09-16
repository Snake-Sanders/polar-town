defmodule PolarWeb.UserLiveAuth do
  import Phoenix.LiveView
  alias Polar.Accounts

  @doc """
  Note that on a real example it should use:
  socket.assigns.current_user.confirmed_at
  See guides:
  https://hexdocs.pm/phoenix_live_view/security-model.html#mounting-considerations
  """
  def on_mount(:default, _params, session, socket) do
    result =
      case session do
        %{"user_id" => user_id} ->
          get_user_by_user_id(user_id)

        %{"user_token" => user_token} ->
          get_user_by_user_token(user_token)

        _any_other -> {:error}
      end

    case result do
      {:error} ->
        {:halt, redirect(socket, to: "/users/log_in")}

      {:ok, user} ->
        socket = assign_new(socket, :current_user, fn -> user end)
        {:cont, socket}
    end
  end

  defp get_user_by_user_token(token) do
    case Accounts.get_user_by_session_token(token) do
      nil ->
        {:error}

      user ->
        {:ok, user}
    end
  end

  defp get_user_by_user_id(id) do
    try do
      Accounts.get_user!(id)
    rescue
      Ecto.NoResultsError -> {:error}
    else
      user -> {:ok, user}
    end
  end
end
