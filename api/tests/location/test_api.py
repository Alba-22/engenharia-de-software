from fastapi.testclient import TestClient
from sqlalchemy.orm import Session

from app.entities import Location, User
from tests.user.conftest import authorization_header, user_in_db


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


def test_post_location_review(
    database: Session,
    test_client: TestClient,
    locations_in_db: list[Location],
    user_in_db: User,
):
    location = locations_in_db[0]
    response = test_client.post(
        f"/locations/{location.id}/review?rate=5",
        headers=authorization_header(user_in_db),
    )
    assert response.status_code == 201
    database.refresh(location)
    assert len(location.reviews) == 1
    assert location.reviews[0].rate == 5
