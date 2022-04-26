defmodule PetClinic.Repo.Migrations.CreateExpertSpecialitiesTable do
  use Ecto.Migration
  import Ecto.Query
  alias PetClinic.Repo
  alias PetClinic.PetClinicService.PetType
  alias PetClinic.PetClinicExperts.PetHealthExpert

  def change do
    types_query = "select name from pet_types"
    types = Ecto.Adapters.SQL.query!(Repo, types_query, [])
    types = types.rows |> List.flatten

    experts_query = "SELECT id,specialities FROM experts"
    experts = Ecto.Adapters.SQL.query!(Repo, experts_query, [])
    experts = experts.rows

    alter table("experts") do
      remove :specialities
    end

    create table("expert_specialities") do
      add :health_expert_id, references("experts")
      add :pet_type_id, references("pet_types")
    end

    flush()
    Enum.each(experts, fn expert ->
      specialities = expert |> List.last |> String.split(",")
      expert_id = expert |> List.first

      Enum.each(specialities, fn speciality  -> 
        %PetType{id: type_id} = Repo.get_by(PetType, name: speciality)
        insert_query = "INSERT INTO expert_specialities (health_expert_id, pet_type_id) 
                          VALUES ($1::integer, $2::integer)"
        Ecto.Adapters.SQL.query!(Repo,insert_query,[expert_id, type_id])
      end)
    end)
  end
end
