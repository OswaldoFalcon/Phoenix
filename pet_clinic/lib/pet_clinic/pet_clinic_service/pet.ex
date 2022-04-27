defmodule PetClinic.PetClinicService.Pet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pets" do
    field :age, :integer
    field :name, :string
   # field :type, :string 
    field :sex, Ecto.Enum, values: [:male, :female]
    belongs_to :type, PetClinic.PetClinicService.PetType
    belongs_to(:owner, PetClinic.PetClinicPetOwner.PetOwner, foreign_key: :owner_id)
    belongs_to(:preferred_expert, PetClinic.PetClinicExperts.PetHealthExpert, foreign_key: :preferred_expert_id) 
    has_many :appointments, PetClinic.AppointmentService.Appointment, foreign_key: :pet_id
    timestamps()
  end

  @doc false
  
  def changeset(pet, attrs \\ %{}) do
    pet
    |> cast(attrs, [:name, :age, :type, :sex])
    |> validate_required([:name, :age, :type, :sex])
    |> validate_number(:age, greater_than_or_equal_to: 0)
  end
end

