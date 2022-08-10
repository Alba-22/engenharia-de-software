from fastapi.testclient import TestClient

from app.entities import Location


def test_get_locations(test_client: TestClient, locations_in_db: list[Location]):
    response = test_client.get("/locations")
    response_json = response.json()
    assert response.status_code == 200
    assert len(response_json) == 2
    for i, location in enumerate(response_json):
        for key, value in location.items():
            if key != "pictures":
                assert str(getattr(locations_in_db[i], key)) == str(value)
            else:
                assert location["pictures"][0]["content"] == f"url_{i+1}"


def test_get_location(test_client: TestClient, locations_in_db: list[Location]):
    for i, location in enumerate(locations_in_db):
        response = test_client.get(f"/locations/{location.id}")
        response_json = response.json()
        assert response.status_code == 200
        for key, value in response_json.items():
            if key != "pictures":
                assert str(getattr(locations_in_db[i], key)) == str(value)
            else:
                assert response_json["pictures"][0]["content"] == f"url_{i+1}"


def test_post_location_review(test_client: TestClient, locations_in_db: list[Location]):
    ...
