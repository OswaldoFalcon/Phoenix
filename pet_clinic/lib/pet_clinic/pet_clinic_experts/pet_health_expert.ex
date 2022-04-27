defmodule PetClinic.PetClinicExperts.PetHealthExpert do
  use Ecto.Schema
  import Ecto.Changeset

  schema "experts" do
    field :age, :integer
    field :email, :string
    field :name, :string
    field :sex, Ecto.Enum, values: [:male, :female]
    #field :specialities, :string
    has_many :pets, PetClinic.PetClinicService.Pet, foreign_key: :preferred_expert_id
    many_to_many :specialities, PetClinic.PetClinicService.PetType, join_through: PetClinic.PetClinicService.ExpertSpecialities, 
                  join_keys: [pet_type_id: :id, health_expert_id: :id]
    has_many :appoinments, PetClinic.AppointmentService.Appointment, foreign_key: :health_expert_id
    timestamps()
  end

  @doc false
  def changeset(pet_health_expert, attrs) do
    pet_health_expert
    |> cast(attrs, [:name, :age, :email, :specialities, :sex])
    |> validate_required([:name, :age, :email, :specialities, :sex])
  end
end
