defmodule PetClinic.PetClinicAppointmentService do
  @moduledoc """
  The PetClinicAppointmentService context.
  """
  import Ecto.Query, warn: false
  alias PetClinic.Repo
  alias PetClinic.AppointmentService.ExpertSchedule
  alias PetClinic.AppointmentService.Appointment

  def create_schedule(attrs \\ %{}) do
    %ExpertSchedule{}
    |> ExpertSchedule.changeset(attrs)
    |> Repo.insert()
  end

  def create_appointment(attrs \\ %{}) do
    %Appointment{}
    |> Appointment.changeset(attrs)
    |> Repo.insert()
  end
end
