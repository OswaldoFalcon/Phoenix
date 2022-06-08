defmodule PetClinic.AppointmentService.ExpertSchedule do
  @moduledoc """
  This module is the Schema of the Table ExpertSchedule.
  Contains the hours avaible in a week for a HealthExpert
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "expert_schedule" do
    belongs_to :health_expert, PetClinic.PetClinicExperts.PetHealthExpert,
      foreign_key: :health_expert_id

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

  def changeset(expert_schedule, attrs \\ %{}) do
    expert_schedule
    |> cast(attrs, [
      :health_expert_id,
      :monday_start,
      :monday_end,
      :tuesday_start,
      :tuesday_end,
      :wednesday_start,
      :wednesday_end,
      :thursday_start,
      :thursday_end,
      :friday_start,
      :friday_end,
      :saturday_start,
      :saturday_end,
      :sunday_start,
      :sunday_end,
      :week_start,
      :week_end
    ])
    |> validate_required([:health_expert_id])
  end
end
