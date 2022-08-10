from typing import Generator

import pytest
from sqlalchemy.orm import Session

from app.entities import Location, Picture


@pytest.fixture
def locations_in_db(database: Session) -> Generator[list[Location], None, None]:
    locations = [
        Location(
            name="Location 1",
            formated_address="Address 1",
            city="City 1",
            state="State 1",
            latitude=1,
            longitude=1,
            pictures=[Picture(content="url_1")],
        ),
        Location(
            name="Location 2",
            formated_address="Address 2",
            city="City 2",
            state="State 2",
            latitude=2,
            longitude=2,
            pictures=[Picture(content="url_2")],
        ),
    ]
    database.add_all(locations)
    database.commit()
    yield locations
    for location in locations:
        database.delete(location)
    database.commit()
