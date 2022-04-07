defmodule PetClinic.Repo do
  use Ecto.Repo,
    otp_app: :pet_clinic,
    adapter: Ecto.Adapters.Postgres
end
