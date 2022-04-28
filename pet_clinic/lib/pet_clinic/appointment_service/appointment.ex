defmodule PetClinic.AppointmentService.Appointment do
    use Ecto.Schema
    schema "appointments" do
      belongs_to :health_expert, PetClinic.PetClinicExperts.PetHealthExpert, foreign_key: :health_expert_id
      belongs_to :pet, PetClinic.PetClinicService.Pet, foreign_key: :pet_id
      field :date, :naive_datetime
      timestamps()
    end
end


#schedule = %ExpertSchedule{health_expert_id: 2, monday_start: ~T[12:00:00], monday_end: ~T[16:00:00], thursday_start: ~T[12:00:00], thursday_end: ~T[17:00:00] }