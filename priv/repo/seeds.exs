# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Polar.Repo.insert!(%Polar.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Polar.Repo
alias Polar.Parkings.Parking

# Parkings.gen_random_parkings(12)

[
  %Parking{
    has_charger: false,
    is_free: true,
    lat: 68.22911613832986,
    lng: 14.565510749816896,
    name: "Fisker Gata",
  },
  %Parking{
    has_charger: false,
    is_free: true,
    lat: 68.23316171555243,
    lng: 14.570867121219637,
    name: "Lamholmen",
  },
  %Parking{
    has_charger: false,
    is_free: true,
    lat: 68.23274097701912,
    lng: 14.55893397331238,
    name: "Lofotgatan",
  },
  %Parking{
    has_charger: false,
    is_free: true,
    lat: 68.23276285959221,
    lng: 14.563153088092806,
    name: "Storgatan",
  },
  %Parking{
    has_charger: false,
    is_free: true,
    lat: 68.23276484891602,
    lng: 14.560784697532656,
    name: "Silver Nilsens Gate",
  }
]
|> Enum.each(&Repo.insert!/1)
