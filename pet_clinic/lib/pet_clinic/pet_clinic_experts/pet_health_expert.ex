defmodule PetClinic.PetClinicExperts.PetHealthExpert do
  use Ecto.Schema
  import Ecto.Changeset

  schema "experts" do
    field :age, :integer
    field :email, :string
    field :name, :string
    field :sex, :string
    field :specialities, :string
    has_many :pets, PetClinic.PetClinicService.Pet
    timestamps()
  end

  @doc false
  def changeset(pet_health_expert, attrs) do
    pet_health_expert
    |> cast(attrs, [:name, :age, :email, :specialities, :sex])
    |> validate_required([:name, :age, :email, :specialities, :sex])
  end
end
