defmodule PetClinic.PetClinicService.Pet do
  @moduledoc """
  This module is the Schema of the Table Pet.
  Has the reltions to oter tables and the valdidations for the fields.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "pets" do
    field :age, :integer
    field :name, :string
    # field :type, :string 
    field :sex, Ecto.Enum, values: [:male, :female]
    belongs_to :type, PetClinic.PetClinicService.PetType
    belongs_to(:owner, PetClinic.PetClinicPetOwner.PetOwner, foreign_key: :owner_id)

    belongs_to(:preferred_expert, PetClinic.PetClinicExperts.PetHealthExpert,
      foreign_key: :preferred_expert_id
    )

    has_many :appointments, PetClinic.AppointmentService.Appointment, foreign_key: :pet_id
    timestamps()
  end

  @doc false

  def changeset(pet, attrs \\ %{}) do
    pet
    |> cast(attrs, [:name, :age, :type_id, :sex, :preferred_expert_id, :owner_id])
    # |> cast_assoc(:type, with: PetClinic.PetClinicService.PetType)
    |> validate_required([:name, :age, :type_id, :sex])
    |> validate_number(:age, greater_than_or_equal_to: 0)
  end
end
