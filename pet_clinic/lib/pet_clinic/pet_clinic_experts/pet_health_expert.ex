defmodule PetClinic.PetClinicExperts.PetHealthExpert do
  @moduledoc """
  This module is the Schema of the Table PetHealtExpert.
  Has the relations to ohter tables and validations.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "experts" do
    field :age, :integer
    field :email, :string
    field :name, :string
    field :sex, Ecto.Enum, values: [:male, :female]
    # field :specialities, :string
    has_many :pets, PetClinic.PetClinicService.Pet, foreign_key: :preferred_expert_id

    many_to_many :specialities, PetClinic.PetClinicService.PetType,
      join_through: PetClinic.PetClinicService.ExpertSpecialities,
      join_keys: [pet_type_id: :id, health_expert_id: :id]

    has_many :appoinments, PetClinic.AppointmentService.Appointment,
      foreign_key: :health_expert_id

    has_one :schedule, PetClinic.AppointmentService.ExpertSchedule, foreign_key: :health_expert_id
    timestamps()
  end

  @doc false
  def changeset(pet_health_expert, attrs) do
    pet_health_expert
    |> cast(attrs, [:name, :age, :email, :sex])
    |> validate_required([:name, :age, :email, :sex])
  end
end
  