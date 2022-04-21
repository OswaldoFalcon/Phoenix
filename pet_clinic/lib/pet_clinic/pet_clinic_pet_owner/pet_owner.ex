defmodule PetClinic.PetClinicPetOwner.PetOwner do
  use Ecto.Schema
  import Ecto.Changeset

  schema "owners" do
    field :age, :integer
    field :email, :string
    field :name, :string
    field :phone_num, :string
    has_many(:pets, PetClinic.PetClinicService.Pet, foreign_key: :owner_id)
    timestamps()
  end

  @doc false
  def changeset(pet_owner, attrs) do
    pet_owner
    |> cast(attrs, [:name, :age, :email, :phone_num])
    |> validate_required([:name, :age, :email, :phone_num])
  end
end
