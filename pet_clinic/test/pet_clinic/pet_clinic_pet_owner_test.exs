defmodule PetClinic.PetClinicPetOwnerTest do
  use PetClinic.DataCase

  alias PetClinic.PetClinicPetOwner

  describe "owners" do
    alias PetClinic.PetClinicPetOwner.PetOwner

    import PetClinic.PetClinicPetOwnerFixtures

    @invalid_attrs %{age: nil, email: nil, name: nil, phone_num: nil}

    test "list_owners/0 returns all owners" do
      pet_owner = pet_owner_fixture()
      assert PetClinicPetOwner.list_owners() == [pet_owner]
    end

    test "get_pet_owner!/1 returns the pet_owner with given id" do
      pet_owner = pet_owner_fixture()
      assert PetClinicPetOwner.get_pet_owner!(pet_owner.id) == pet_owner
    end

    test "create_pet_owner/1 with valid data creates a pet_owner" do
      valid_attrs = %{age: 42, email: "some email", name: "some name", phone_num: "some phone_num"}

      assert {:ok, %PetOwner{} = pet_owner} = PetClinicPetOwner.create_pet_owner(valid_attrs)
      assert pet_owner.age == 42
      assert pet_owner.email == "some email"
      assert pet_owner.name == "some name"
      assert pet_owner.phone_num == "some phone_num"
    end

    test "create_pet_owner/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PetClinicPetOwner.create_pet_owner(@invalid_attrs)
    end

    test "update_pet_owner/2 with valid data updates the pet_owner" do
      pet_owner = pet_owner_fixture()
      update_attrs = %{age: 43, email: "some updated email", name: "some updated name", phone_num: "some updated phone_num"}

      assert {:ok, %PetOwner{} = pet_owner} = PetClinicPetOwner.update_pet_owner(pet_owner, update_attrs)
      assert pet_owner.age == 43
      assert pet_owner.email == "some updated email"
      assert pet_owner.name == "some updated name"
      assert pet_owner.phone_num == "some updated phone_num"
    end

    test "update_pet_owner/2 with invalid data returns error changeset" do
      pet_owner = pet_owner_fixture()
      assert {:error, %Ecto.Changeset{}} = PetClinicPetOwner.update_pet_owner(pet_owner, @invalid_attrs)
      assert pet_owner == PetClinicPetOwner.get_pet_owner!(pet_owner.id)
    end

    test "delete_pet_owner/1 deletes the pet_owner" do
      pet_owner = pet_owner_fixture()
      assert {:ok, %PetOwner{}} = PetClinicPetOwner.delete_pet_owner(pet_owner)
      assert_raise Ecto.NoResultsError, fn -> PetClinicPetOwner.get_pet_owner!(pet_owner.id) end
    end

    test "change_pet_owner/1 returns a pet_owner changeset" do
      pet_owner = pet_owner_fixture()
      assert %Ecto.Changeset{} = PetClinicPetOwner.change_pet_owner(pet_owner)
    end
  end
end
