defmodule PetClinic.PetClinicPetOwnerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PetClinic.PetClinicPetOwner` context.
  """

  @doc """
  Generate a pet_owner.
  """
  def pet_owner_fixture(attrs \\ %{}) do
    {:ok, pet_owner} =
      attrs
      |> Enum.into(%{
        age: 42,
        email: "some email",
        name: "some name",
        phone_num: "some phone_num"
      })
      |> PetClinic.PetClinicPetOwner.create_pet_owner()

    pet_owner
  end
end
