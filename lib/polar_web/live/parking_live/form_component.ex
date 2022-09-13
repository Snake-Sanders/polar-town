defmodule PolarWeb.ParkingLive.FormComponent do
  use PolarWeb, :live_component

  alias Polar.Parkings

  @impl true
  def update(%{parking: parking} = assigns, socket) do
    changeset = Parkings.change_parking(parking)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"parking" => parking_params}, socket) do
    changeset =
      socket.assigns.parking
      |> Parkings.change_parking(parking_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"parking" => parking_params}, socket) do
    save_parking(socket, socket.assigns.action, parking_params)
  end

  defp save_parking(socket, :edit, parking_params) do
    case Parkings.update_parking(socket.assigns.parking, parking_params) do
      {:ok, _parking} ->
        {:noreply,
         socket
         |> put_flash(:info, "Parking updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_parking(socket, :new, parking_params) do
    case Parkings.create_parking(parking_params) do
      {:ok, _parking} ->
        {:noreply,
         socket
         |> put_flash(:info, "Parking created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
