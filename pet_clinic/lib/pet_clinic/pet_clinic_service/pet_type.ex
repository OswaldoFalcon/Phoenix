defmodule PetClinic.PetClinicService.PetType do
  @moduledoc """
  This module is the Schema of the Table PetType.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "pet_types" do
    field :name, :string
    has_many :pets, PetClinic.PetClinicService.Pet, foreign_key: :type_id
    timestamps()
  end

  def changeset(pet, attrs) do
    pet
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
