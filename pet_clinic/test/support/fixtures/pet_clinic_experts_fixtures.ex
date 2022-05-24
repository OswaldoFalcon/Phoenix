defmodule PetClinic.PetClinicExpertsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PetClinic.PetClinicExperts` context.
  """

  @doc """
  Generate a pet_health_expert.
  """
  def pet_health_expert_fixture(attrs \\ %{}) do
    {:ok, pet_health_expert} =
      attrs
      |> Enum.into(%{
        age: 42,
        email: "some email",
        name: "some name",
        sex: :male
      })
      |> PetClinic.PetClinicExperts.create_pet_health_expert()

    pet_health_expert
  end
end
