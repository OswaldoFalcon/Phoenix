defmodule PetClinic.Repo.Migrations.CorrectExpertSexD do
  use Ecto.Migration
  use Ecto.Migration
  alias PetClinic.Repo

  def change do
    query = "update experts set sex = lower(sex)"
    Ecto.Adapters.SQL.query!(Repo, query, [])

    query = "update experts set sex = 'female' where sex not in ('male','female')"
    Ecto.Adapters.SQL.query!(Repo, query, [])
  end
end
