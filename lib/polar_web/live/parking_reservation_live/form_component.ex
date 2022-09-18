defmodule PolarWeb.ParkingReservationLive.FormComponent do
  use PolarWeb, :live_component

  alias Polar.Reservations

  @impl true
  def update(%{parking_reservation: parking_reservation} = assigns, socket) do
    changeset = Reservations.change_parking_reservation(parking_reservation)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"parking_reservation" => parking_reservation_params}, socket) do
    changeset =
      socket.assigns.parking_reservation
      |> Reservations.change_parking_reservation(parking_reservation_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"parking_reservation" => parking_reservation_params}, socket) do
    save_parking_reservation(socket, socket.assigns.action, parking_reservation_params)
  end

  defp save_parking_reservation(socket, :edit, parking_reservation_params) do
    case Reservations.update_parking_reservation(socket.assigns.parking_reservation, parking_reservation_params) do
      {:ok, _parking_reservation} ->
        {:noreply,
         socket
         |> put_flash(:info, "Parking reservation updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_parking_reservation(socket, :new, parking_reservation_params) do
    case Reservations.create_parking_reservation(parking_reservation_params) do
      {:ok, _parking_reservation} ->
        {:noreply,
         socket
         |> put_flash(:info, "Parking reservation created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
