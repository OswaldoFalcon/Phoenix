defmodule PetClinic.Repo.Migrations.RelateHealthExpertWithPets do
  use Ecto.Migration

  def change do
    alter table ("pets") do
      add :pet_health_expert_id, references("experts")
    end
  end
end
