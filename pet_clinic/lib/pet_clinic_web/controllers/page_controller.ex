defmodule PetClinicWeb.PageController do
  use PetClinicWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
