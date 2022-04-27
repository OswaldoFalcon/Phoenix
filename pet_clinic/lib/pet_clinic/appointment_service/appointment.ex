defmodule PetClinic.AppointmentService.Appointment do
    use Ecto.Schema
    schema "appointments" do
      belongs_to :health_expert, PetClinic.PetClinicExperts.PetHealthExpert, foreign_key: :health_expert_id
      belongs_to :pet, PetClinic.PetClinicService.Pet, foreign_key: :pet_id
      field :date, :naive_datetime
      timestamps()
    end
end