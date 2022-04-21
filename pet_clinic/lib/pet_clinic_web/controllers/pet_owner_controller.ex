defmodule PetClinicWeb.PetOwnerController do
  use PetClinicWeb, :controller

  alias PetClinic.PetClinicPetOwner
  alias PetClinic.PetClinicPetOwner.PetOwner

  def index(conn, _params) do
    owners = PetClinicPetOwner.list_owners()
    render(conn, "index.html", owners: owners)
  end

  def new(conn, _params) do
    changeset = PetClinicPetOwner.change_pet_owner(%PetOwner{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"pet_owner" => pet_owner_params}) do
    case PetClinicPetOwner.create_pet_owner(pet_owner_params) do
      {:ok, pet_owner} ->
        conn
        |> put_flash(:info, "Pet owner created successfully.")
        |> redirect(to: Routes.pet_owner_path(conn, :show, pet_owner))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    pet_owner = PetClinicPetOwner.get_pet_owner!(id)
    render(conn, "show.html", pet_owner: pet_owner)
  end

  def edit(conn, %{"id" => id}) do
    pet_owner = PetClinicPetOwner.get_pet_owner!(id)
    changeset = PetClinicPetOwner.change_pet_owner(pet_owner)
    render(conn, "edit.html", pet_owner: pet_owner, changeset: changeset)
  end

  def update(conn, %{"id" => id, "pet_owner" => pet_owner_params}) do
    pet_owner = PetClinicPetOwner.get_pet_owner!(id)

    case PetClinicPetOwner.update_pet_owner(pet_owner, pet_owner_params) do
      {:ok, pet_owner} ->
        conn
        |> put_flash(:info, "Pet owner updated successfully.")
        |> redirect(to: Routes.pet_owner_path(conn, :show, pet_owner))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", pet_owner: pet_owner, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    pet_owner = PetClinicPetOwner.get_pet_owner!(id)
    {:ok, _pet_owner} = PetClinicPetOwner.delete_pet_owner(pet_owner)

    conn
    |> put_flash(:info, "Pet owner deleted successfully.")
    |> redirect(to: Routes.pet_owner_path(conn, :index))
  end
end
