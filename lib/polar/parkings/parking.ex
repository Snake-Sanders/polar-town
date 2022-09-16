defmodule Polar.Parkings.Parking do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :name, :lat, :lng]}

  schema "parkings" do
    field :has_charger, :boolean, default: false
    field :is_free, :boolean, default: true
    field :name, :string
    field :lat, :float, default: 0.0
    field :lng, :float, default: 0.0
    timestamps()
  end

  @doc false
  def changeset(parking, attrs) do
    parking
    |> cast(attrs, [:name, :is_free, :has_charger, :lat, :lng])
    |> validate_required([:name])
    |> validate_number(:lat, greater_than_or_equal_to: 0.0)
    |> validate_number(:lng, greater_than_or_equal_to: 0.0)
    |> IO.inspect(label: "changeset!!!!")
  end
end
