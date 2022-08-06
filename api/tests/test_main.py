from fastapi.testclient import TestClient


def test_healthcheck(test_client: TestClient):
    response = test_client.get("/")
    assert response.status_code == 204
