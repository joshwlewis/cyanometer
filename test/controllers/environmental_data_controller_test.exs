defmodule Cyanometer.EnvironmentalDataControllerTest do
  use Cyanometer.ConnCase
  require Logger

  alias Cyanometer.Repo
  alias Cyanometer.EnvironmentalData


  @valid_attrs %{"air_pollution_index": "20",
                "icon": "sun",
                "taken_at": "2016-06-05T16:04:17"}

  @invalid_attrs %{"icon": "invalid-icon"}

  describe "public endpoints:" do
    test "GET /api/environmental_data/:id - shows chosen resource", %{conn: conn} do
      location = insert_location()
      ed = insert_environmental_data(Map.merge(@valid_attrs, %{location_id: location.id}))

      conn =
        conn
        |> get(environmental_data_path(conn, :show, ed))

      assert Poison.encode!(json_response(conn, 200)) == Poison.encode! ed
    end

    test "GET /api/environmental_data/:id - does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
      assert_error_sent 404, fn ->
        conn
        |> get(environmental_data_path(conn, :show, -1))
      end
    end
  end

  describe "authenticated endpoints with a valid JWT:" do
    setup [:set_json_header, :set_authorised_header]

    test "POST /api/environmental_data - creates and renders resource when data is valid", %{conn: conn} do
      location = insert_location()
      url = environmental_data_path(conn, :create)
      conn =
        conn
          |> post(url, environmental_data: Map.merge(@valid_attrs, %{location_id: location.id}))

      assert json_response(conn, 201)["id"]
      assert Repo.get(EnvironmentalData, Poison.decode!(conn.resp_body)["id"])
    end

    test "POST /api/environmental_data - does not create resource and renders errors when data is invalid", %{conn: conn} do
      url = environmental_data_path(conn, :create)

      conn =
        conn
        |> post(url, environmental_data: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end
end
