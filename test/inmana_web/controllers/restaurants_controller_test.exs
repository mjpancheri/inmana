defmodule InmanaWeb.RestaurantsControllerTest do
  use InmanaWeb.ConnCase, async: true

  describe "create/2" do
    test "when all params are valid, creates the user", %{conn: conn} do
      params = %{name: "Siri cascudo", email: "siri@cascudo.com"}

      response =
        conn
        |> post(Routes.restaurants_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "message" => "Restaurant created!",
               "restaurant" => %{
                 "email" => "siri@cascudo.com",
                 "id" => _id,
                 "name" => "Siri cascudo"
               }
             } = response
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      params = %{name: "", email: "siri@cascudo.com"}
      expected_response = %{"message" => %{"name" => ["can't be blank"]}}

      response =
        conn
        |> post(Routes.restaurants_path(conn, :create, params))
        |> json_response(:bad_request)

      assert response == expected_response
    end
  end

  describe "show/2" do
    test "when uuid is valid, show the user", %{conn: conn} do
      params = %{name: "Siri cascudo", email: "siri@cascudo.com"}
      {:ok, restaurant} = Inmana.create_restaurant(params)

      response =
        conn
        |> get(Routes.restaurants_path(conn, :show, restaurant.id))
        |> json_response(:ok)

      assert %{
               "restaurant" => %{
                 "email" => "siri@cascudo.com",
                 "id" => _id,
                 "name" => "Siri cascudo"
               }
             } = response
    end

    test "when uuid is invalid, returns an error", %{conn: conn} do
      expected_response = %{"message" => "Restaurant not found"}

      response =
        conn
        |> get(Routes.restaurants_path(conn, :show, "136b23c1-1da4-4048-a9b4-6048a83f6e50"))
        |> json_response(:not_found)

      assert response == expected_response
    end
  end
end
