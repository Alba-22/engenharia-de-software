from fastapi.testclient import TestClient
from sqlalchemy.orm import Session

from app.entities import Tour, User
from tests.user.conftest import authorization_header, user_in_db


def test_get_tours(test_client: TestClient, tours_in_db: list[Tour]):
    response = test_client.get("/tours")
    response_json = response.json()
    assert response.status_code == 200
    assert len(response_json) == 2
    for i, tour in enumerate(response_json):
        for key, value in tour.items():
            if key == "id":
                assert str(getattr(tours_in_db[i], key)) == str(value)
            if key == "user":
                assert tour["user"]["id"] == str(tours_in_db[i].user.id)


def test_get_tour(test_client: TestClient, tours_in_db: list[Tour]):
    for i, tour in enumerate(tours_in_db):
        response = test_client.get(f"/tours/{tour.id}")
        response_json = response.json()
        assert response.status_code == 200
        for key, value in response_json.items():
            if key == "id":
                assert str(getattr(tours_in_db[i], key)) == str(value)
            if key == "user":
                assert response_json["user"]["id"] == str(tour.user.id)


def test_post_tour_review(
    database: Session,
    test_client: TestClient,
    tours_in_db: list[Tour],
    user_in_db: User,
):
    tour = tours_in_db[0]
    response = test_client.post(
        f"/tours/{tour.id}/review?rate=5",
        headers=authorization_header(user_in_db),
    )
    assert response.status_code == 201
    database.refresh(tour)
    assert len(tour.reviews) == 1
    assert tour.reviews[0].rate == 5
