defmodule PetClinic.PetClinicService.PetType do
    use Ecto.Schema
    
    schema "pet_types" do
      field :name, :string
      has_many :pets, PetClinic.PetClinicService.Pet, foreign_key: :type_id
      timestamps()
    end
end