defmodule PetClinic.PetClinicServiceFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PetClinic.PetClinicService` context.
  """

  @doc """
  Generate a pet.
  """
  alias PetClinic.PetClinicExpertsFixtures
  alias PetClinic.PetClinicPetOwnerFixtures

  def pet_fixture(attrs \\ %{}) do
    preferred_expert = PetClinicExpertsFixtures.pet_health_expert_fixture()
    owner = PetClinicPetOwnerFixtures.pet_owner_fixture()
    pet_type = type_fixture()

    {:ok, pet} =
      attrs
      |> Enum.into(%{
        age: 42,
        name: "some name",
        sex: :male,
        type_id: pet_type.id,
        preferred_expert_id: preferred_expert.id,
        owner_id: owner.id
      })
      |> PetClinic.PetClinicService.create_pet()

    pet
  end

  def type_fixture(attrs \\ %{}) do
    {:ok, type} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> PetClinic.PetClinicService.create_type()

    type
  end
end
