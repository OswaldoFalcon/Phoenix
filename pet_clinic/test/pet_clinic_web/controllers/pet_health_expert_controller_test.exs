defmodule PetClinicWeb.PetHealthExpertControllerTest do
  use PetClinicWeb.ConnCase

  import PetClinic.PetClinicExpertsFixtures

  @create_attrs %{
    age: 42,
    email: "some email",
    name: "some name",
    sex: :male
    # specialities: "some specialities"
  }
  @update_attrs %{
    age: 43,
    email: "some updated email",
    name: "some updated name",
    sex: :male
    # specialities: "some updated specialities"
  }
  @invalid_attrs %{age: nil, email: nil, name: nil, sex: nil, specialities: nil}

  describe "index" do
    test "lists all experts", %{conn: conn} do
      conn = get(conn, Routes.pet_health_expert_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Experts"
    end
  end

  describe "new pet_health_expert" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.pet_health_expert_path(conn, :new))
      assert html_response(conn, 200) =~ "New Pet health expert"
    end
  end

  describe "create pet_health_expert" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn =
        post(conn, Routes.pet_health_expert_path(conn, :create), pet_health_expert: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.pet_health_expert_path(conn, :show, id)

      conn = get(conn, Routes.pet_health_expert_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Pet health expert"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn =
        post(conn, Routes.pet_health_expert_path(conn, :create), pet_health_expert: @invalid_attrs)

      assert html_response(conn, 200) =~ "New Pet health expert"
    end
  end

  describe "edit pet_health_expert" do
    setup [:create_pet_health_expert]

    test "renders form for editing chosen pet_health_expert", %{
      conn: conn,
      pet_health_expert: pet_health_expert
    } do
      conn = get(conn, Routes.pet_health_expert_path(conn, :edit, pet_health_expert))
      assert html_response(conn, 200) =~ "Edit Pet health expert"
    end
  end

  describe "update pet_health_expert" do
    setup [:create_pet_health_expert]

    test "redirects when data is valid", %{conn: conn, pet_health_expert: pet_health_expert} do
      conn =
        put(conn, Routes.pet_health_expert_path(conn, :update, pet_health_expert),
          pet_health_expert: @update_attrs
        )

      assert redirected_to(conn) == Routes.pet_health_expert_path(conn, :show, pet_health_expert)

      conn = get(conn, Routes.pet_health_expert_path(conn, :show, pet_health_expert))
      assert html_response(conn, 200) =~ "some updated email"
    end

    test "renders errors when data is invalid", %{
      conn: conn,
      pet_health_expert: pet_health_expert
    } do
      conn =
        put(conn, Routes.pet_health_expert_path(conn, :update, pet_health_expert),
          pet_health_expert: @invalid_attrs
        )

      assert html_response(conn, 200) =~ "Edit Pet health expert"
    end
  end

  describe "delete pet_health_expert" do
    setup [:create_pet_health_expert]

    test "deletes chosen pet_health_expert", %{conn: conn, pet_health_expert: pet_health_expert} do
      conn = delete(conn, Routes.pet_health_expert_path(conn, :delete, pet_health_expert))
      assert redirected_to(conn) == Routes.pet_health_expert_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.pet_health_expert_path(conn, :show, pet_health_expert))
      end
    end
  end

  defp create_pet_health_expert(_) do
    pet_health_expert = pet_health_expert_fixture()
    %{pet_health_expert: pet_health_expert}
  end
end
