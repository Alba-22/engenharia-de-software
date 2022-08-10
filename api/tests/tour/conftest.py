import pytest
from sqlalchemy.orm import Session

from app.entities import Location, Tour, TourLocation, User
from tests.location.conftest import locations_in_db
from tests.user.conftest import user_in_db


@pytest.fixture
def tours_in_db(database: Session, locations_in_db: list[Location], user_in_db: User):
    tours = [
        Tour(
            user_id=user_in_db.id,
            location_image_index=0,
            locations=[
                TourLocation(location_id=location.id, index=i)
                for i, location in enumerate(locations_in_db)
            ],
        ),
        Tour(
            user_id=user_in_db.id,
            location_image_index=0,
            locations=[TourLocation(location_id=locations_in_db[0].id, index=0)],
        ),
    ]
    database.add_all(tours)
    database.commit()
    yield tours
    for tour in tours:
        database.delete(tour)
    database.commit()
