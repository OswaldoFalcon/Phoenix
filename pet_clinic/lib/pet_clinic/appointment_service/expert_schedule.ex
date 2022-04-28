defmodule PetClinic.AppointmentService.ExpertSchedule do
    use Ecto.Schema
    schema "expert_schedule" do
        
      belongs_to :health_expert, PetClinic.PetClinicExperts.PetHealthExpert, foreign_key: :health_expert_id
      field :monday_start, :time
      field :monday_end, :time
      field :tuesday_start, :time
      field :tuesday_end, :time
      field :wednesday_start, :time
      field :wednesday_end, :time
      field :thursday_start, :time
      field :thursday_end, :time
      field :friday_start, :time
      field :friday_end, :time
      field :saturday_start, :time
      field :saturday_end, :time
      field :sunday_start, :time
      field :sunday_end, :time
      field :week_start, :date
      field :week_end, :date
    end
end