defmodule PetClinicWeb.PetOwnerControllerTest do
  use PetClinicWeb.ConnCase

  import PetClinic.PetClinicPetOwnerFixtures

  @create_attrs %{age: 42, email: "some email", name: "some name", phone_num: "some phone_num"}
  @update_attrs %{
    age: 43,
    email: "some updated email",
    name: "some updated name",
    phone_num: "some updated phone_num"
  }
  @invalid_attrs %{age: nil, email: nil, name: nil, phone_num: nil}

  describe "index" do
    test "lists all owners", %{conn: conn} do
      conn = get(conn, Routes.pet_owner_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Owners"
    end
  end

  describe "new pet_owner" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.pet_owner_path(conn, :new))
      assert html_response(conn, 200) =~ "New Pet owner"
    end
  end

  describe "create pet_owner" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.pet_owner_path(conn, :create), pet_owner: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.pet_owner_path(conn, :show, id)

      conn = get(conn, Routes.pet_owner_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Pet owner"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.pet_owner_path(conn, :create), pet_owner: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Pet owner"
    end
  end

  describe "edit pet_owner" do
    setup [:create_pet_owner]

    test "renders form for editing chosen pet_owner", %{conn: conn, pet_owner: pet_owner} do
      conn = get(conn, Routes.pet_owner_path(conn, :edit, pet_owner))
      assert html_response(conn, 200) =~ "Edit Pet owner"
    end
  end

  describe "update pet_owner" do
    setup [:create_pet_owner]

    test "redirects when data is valid", %{conn: conn, pet_owner: pet_owner} do
      conn = put(conn, Routes.pet_owner_path(conn, :update, pet_owner), pet_owner: @update_attrs)
      assert redirected_to(conn) == Routes.pet_owner_path(conn, :show, pet_owner)

      conn = get(conn, Routes.pet_owner_path(conn, :show, pet_owner))
      assert html_response(conn, 200) =~ "some updated email"
    end

    test "renders errors when data is invalid", %{conn: conn, pet_owner: pet_owner} do
      conn = put(conn, Routes.pet_owner_path(conn, :update, pet_owner), pet_owner: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Pet owner"
    end
  end

  describe "delete pet_owner" do
    setup [:create_pet_owner]

    test "deletes chosen pet_owner", %{conn: conn, pet_owner: pet_owner} do
      conn = delete(conn, Routes.pet_owner_path(conn, :delete, pet_owner))
      assert redirected_to(conn) == Routes.pet_owner_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.pet_owner_path(conn, :show, pet_owner))
      end
    end
  end

  defp create_pet_owner(_) do
    pet_owner = pet_owner_fixture()
    %{pet_owner: pet_owner}
  end
end
