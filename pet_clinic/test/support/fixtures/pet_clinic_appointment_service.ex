defmodule PetClinic.AppointmentServiceFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PetClinic.AppointmentService.AppointmentService` context.
  """
  alias PetClinic.PetClinicExpertsFixtures
  alias PetClinic.PetClinicServiceFixtures
  alias PetClinic.Repo

  def expert_schedule_fixtures(attrs \\ %{}) do
    health_expert = PetClinicExpertsFixtures.pet_health_expert_fixture()

    {:ok, expert_schedule} =
      attrs
      |> Enum.into(%{
        health_expert_id: health_expert.id,
        monday_start: ~T[12:00:00],
        monday_end: ~T[13:00:00]
      })
      |> PetClinic.PetClinicAppointmentService.create_schedule()

    expert_schedule
  end

  def appoinment_fixtures(attrs \\ %{}) do
    health_expert = PetClinicExpertsFixtures.pet_health_expert_fixture()
    pet = PetClinicServiceFixtures.pet_fixture()

    {:ok, appoinment} =
      attrs
      |> Enum.into(%{
        health_expert_id: health_expert.id,
        pet_id: pet.id,
        date: ~N[2022-05-31 13:00:00]
      })
      |> PetClinic.PetClinicAppointmentService.create_appointment()

    appoinment |> Repo.preload(:pet)
  end
end
