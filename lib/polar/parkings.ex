defmodule Polar.Parkings do
  @moduledoc """
  The Parkings context.
  """

  import Ecto.Query, warn: false
  alias Polar.Repo

  alias Polar.Parkings.Parking

  @doc """
  Returns the list of parkings.

  ## Examples

      iex> list_parkings()
      [%Parking{}, ...]

  """
  def list_parkings do
    Repo.all(Parking)
  end

  @doc """
  Gets a single parking.

  Raises `Ecto.NoResultsError` if the Parking does not exist.

  ## Examples

      iex> get_parking!(123)
      %Parking{}

      iex> get_parking!(456)
      ** (Ecto.NoResultsError)

  """
  def get_parking!(id), do: Repo.get!(Parking, id)

  @doc """
  Creates a parking.

  ## Examples

      iex> create_parking(%{field: value})
      {:ok, %Parking{}}

      iex> create_parking(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_parking(attrs \\ %{}) do
    %Parking{}
    |> Parking.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a parking.

  ## Examples

      iex> update_parking(parking, %{field: new_value})
      {:ok, %Parking{}}

      iex> update_parking(parking, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_parking(%Parking{} = parking, attrs) do
    parking
    |> Parking.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a parking.

  ## Examples

      iex> delete_parking(parking)
      {:ok, %Parking{}}

      iex> delete_parking(parking)
      {:error, %Ecto.Changeset{}}

  """
  def delete_parking(%Parking{} = parking) do
    Repo.delete(parking)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking parking changes.

  ## Examples

      iex> change_parking(parking)
      %Ecto.Changeset{data: %Parking{}}

  """
  def change_parking(%Parking{} = parking, attrs \\ %{}) do
    Parking.changeset(parking, attrs)
  end
end
