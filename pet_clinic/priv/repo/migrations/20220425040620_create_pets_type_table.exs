defmodule PetClinic.Repo.Migrations.CreatePetsTypeTable do
  use Ecto.Migration

  import Ecto.Query

  alias PetClinic.Repo
  alias PetClinic.PetClinicService.Pet

  def change do
    #Seleccionamos los nombres de pets
    query_pets = "select name,type from pets;"
    pets_map = Ecto.Adapters.SQL.query!(Repo,query_pets,[])
    pets = pets_map.rows 
    #Seleccionamos los nombres de types
    query_types = "select distinct type from pets;"
    types_map = Ecto.Adapters.SQL.query!(Repo,query_types,[])
    types = types_map.rows |> List.flatten

    create table("pet_types") do
      add :name, :string
      timestamps()  
    end

    flush()
    Enum.each(types, fn t ->
      query_insert_types = "INSERT INTO pet_types (name,inserted_at, updated_at) VALUES($1::varchar, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);"
     Ecto.Adapters.SQL.query!(Repo,query_insert_types,[t])
    end)

    alter table("pets") do
      remove :type
      add :type_id, references("pet_types")
    end

    flush()
    Enum.each(pets, fn pet ->
       
      name_pet = List.first(pet)
      type = List.last(pet)

      query_pet_type_id = "SELECT id FROM pet_types WHERE name = $1::varchar ;"
      pet_type_id = Ecto.Adapters.SQL.query!(Repo,query_pet_type_id,[type])
      pet_type_id = pet_type_id.rows |> List.flatten |> List.first
      query_update = "UPDATE pets SET type_id = $1::integer where name = $2::varchar;" 
      Ecto.Adapters.SQL.query!(Repo,query_update,[pet_type_id,name_pet])
    end)

   # Enum.each(pets, fn pet ->
   #   %PetType{id: pet_type_id} = Repo.get_by(PetType, name: pet.type)
   #   update = "update pets set type_id = $1::integer where id = $2::integer"
   #   Ecto.Adapters.SQL.query!(Repo, update, [pet_type_id, pet.id])
   # end)
  end
end
