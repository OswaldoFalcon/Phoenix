defmodule PetClinic.Repo.Migrations.CreateAppointmentTable do
  use Ecto.Migration

  def change do
    create table("appointments") do
      add :pet_id, references("pets")
      add :health_expert_id, references("experts")
      add :date, :naive_datetime
      timestamps()
    end
  end
end
