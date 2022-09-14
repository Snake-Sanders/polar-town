defmodule Polar.Parkings.Parking do
  use Ecto.Schema
  import Ecto.Changeset

  schema "parkings" do
    field :has_charger, :boolean, default: false
    field :is_free, :boolean, default: true
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(parking, attrs) do
    parking
    |> cast(attrs, [:name, :is_free, :has_charger])
    |> validate_required([:name])
  end
end
