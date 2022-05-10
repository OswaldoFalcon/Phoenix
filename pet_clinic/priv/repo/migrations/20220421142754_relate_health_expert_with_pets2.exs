defmodule PetClinic.Repo.Migrations.RelateHealthExpertWithPets2 do
  use Ecto.Migration

  def change do
    alter table("pets") do
      add :preferred_expert_id, references("experts")
    end
  end
end
