defmodule PetClinic.AppointmentService.Appointment do
  @moduledoc """
  This module is the Schema of the Table Appointment.
  Has a relation to the PetHealthExpert and Pet table.
  And the fields to do an Appointment.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "appointments" do
    belongs_to :heainlth_expert, PetClinic.PetClinicExperts.PetHealthExpert,
      foreign_key: :health_expert_id

    belongs_to :pet, PetClinic.PetClinicService.Pet, foreign_key: :pet_id
    field :date, :naive_datetime
    timestamps()
  end

  def changeset(appoinment, attrs) do
    appoinment
    |> cast(attrs, [:health_expert_id, :pet_id, :date])
    |> validate_required([:health_expert_id, :pet_id, :date])
  end
end

# schedule = %ExpertSchedule{health_expert_id: 2, monday_start: ~T[12:00:00], monday_end: ~T[16:00:00], thursday_start: ~T[12:00:00], thursday_end: ~T[17:00:00] }
