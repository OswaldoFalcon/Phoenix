defmodule PetClinic.Repo.Migrations.CreateOwners do
  use Ecto.Migration

  def change do
    create table(:owners) do
      add :name, :string
      add :age, :integer
      add :email, :string
      add :phone_num, :string
      timestamps()
    end
  end
end
