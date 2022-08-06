from typing import Generator

import pytest
from fastapi.testclient import TestClient
from sqlalchemy.orm import Session

from app.db import sessionmaker
from app.main import app


@pytest.fixture
def test_client() -> TestClient:
    return TestClient(app)


@pytest.fixture
def database() -> Generator[Session, None, None]:
    db = sessionmaker()
    yield db
    db.close()
