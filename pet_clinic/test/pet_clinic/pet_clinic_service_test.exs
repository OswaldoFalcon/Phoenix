defmodule PetClinic.PetClinicServiceTest do
  use PetClinic.DataCase

  alias PetClinic.PetClinicService

  describe "pets" do
    alias PetClinic.PetClinicService.Pet

    import PetClinic.PetClinicServiceFixtures

    @invalid_attrs %{age: nil, name: nil, sex: nil, type: nil}

    test "list_pets/0 returns all pets" do
      pet = pet_fixture()
      assert PetClinicService.list_pets() == [pet]
    end

    test "get_pet!/1 returns the pet with given id" do
      pet = pet_fixture()
      assert PetClinicService.get_pet!(pet.id) == pet
    end

    test "create_pet/1 with valid data creates a pet" do
      pet_type = type_fixture()
      valid_attrs = %{age: 42, name: "some name", sex: :male, type_id: pet_type.id}

      assert {:ok, %Pet{} = pet} = PetClinicService.create_pet(valid_attrs)
      assert pet.age == 42
      assert pet.name == "some name"
      assert pet.sex == :male
    end

    test "create_pet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PetClinicService.create_pet(@invalid_attrs)
    end

    test "update_pet/2 with valid data updates the pet" do
      pet = pet_fixture()
      pet_type = type_fixture()

      update_attrs = %{
        age: 43,
        name: "some updated name",
        sex: :male,
        type: pet_type.id
      }

      assert {:ok, %Pet{} = pet} = PetClinicService.update_pet(pet, update_attrs)
      assert pet.age == 43
      assert pet.name == "some updated name"
      assert pet.sex == :male
    end

    test "update_pet/2 with invalid data returns error changeset" do
      pet = pet_fixture()
      assert {:error, %Ecto.Changeset{}} = PetClinicService.update_pet(pet, @invalid_attrs)
      assert pet == PetClinicService.get_pet!(pet.id)
    end

    test "delete_pet/1 deletes the pet" do
      pet = pet_fixture()
      assert {:ok, %Pet{}} = PetClinicService.delete_pet(pet)
      assert_raise Ecto.NoResultsError, fn -> PetClinicService.get_pet!(pet.id) end
    end

    test "change_pet/1 returns a pet changeset" do
      pet = pet_fixture()
      assert %Ecto.Changeset{} = PetClinicService.change_pet(pet)
    end
  end
end
