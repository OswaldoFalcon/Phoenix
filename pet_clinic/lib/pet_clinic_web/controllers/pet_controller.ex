defmodule PetClinicWeb.PetController do
  use PetClinicWeb, :controller

  alias PetClinic.PetClinicService
  alias PetClinic.PetClinicService.Pet
  alias PetClinic.PetClinicPetOwner
  alias PetClinic.PetClinicExperts

  def index(conn, _params) do
    pets = PetClinicService.list_pets()
    render(conn, "index.html", pets: pets)
  end

  def new(conn, _params) do
    changeset = PetClinicService.change_pet(%Pet{})
    pet_types = PetClinicService.list_pet_by_type()
    owners = PetClinicPetOwner.list_owners()
    experts = PetClinicExperts.list_experts()

    render(conn, "new.html",
      pet_types: pet_types,
      owners: owners,
      experts: experts,
      changeset: changeset
    )
  end

  def create(conn, %{"pet" => pet_params}) do
    case PetClinicService.create_pet(pet_params) do
      {:ok, pet} ->
        conn
        |> put_flash(:info, "Pet created successfully.")
        |> redirect(to: Routes.pet_path(conn, :show, pet))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    pet = PetClinicService.get_pet!(id)
    owner = PetClinic.PetClinicPetOwner.get_pet_owner!(pet.owner_id)
    expert = PetClinic.PetClinicExperts.get_pet_health_expert!(pet.preferred_expert_id)
    render(conn, "show.html", pet: pet, owner: owner, expert: expert)
  end

  def edit(conn, %{"id" => id}) do
    pet = PetClinicService.get_pet!(id)
    changeset = PetClinicService.change_pet(pet)
    pet_types = PetClinicService.list_pet_by_type()
    owners = PetClinicPetOwner.list_owners()
    experts = PetClinicExperts.list_experts()

    render(conn, "edit.html",
      pet: pet,
      pet_types: pet_types,
      owners: owners,
      experts: experts,
      changeset: changeset
    )
  end

  def update(conn, %{"id" => id, "pet" => pet_params}) do
    pet = PetClinicService.get_pet!(id)

    case PetClinicService.update_pet(pet, pet_params) do
      {:ok, pet} ->
        conn
        |> put_flash(:info, "Pet updated successfully.")
        |> redirect(to: Routes.pet_path(conn, :show, pet))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", pet: pet, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    pet = PetClinicService.get_pet!(id)
    {:ok, _pet} = PetClinicService.delete_pet(pet)

    conn
    |> put_flash(:info, "Pet deleted successfully.")
    |> redirect(to: Routes.pet_path(conn, :index))
  end

  def index_by_type(conn, %{"type" => type}) do
    pet = PetClinicService.list_pets_by_type(type)
    render(conn, "index_by_type.html", pets: pet)
  end
end
