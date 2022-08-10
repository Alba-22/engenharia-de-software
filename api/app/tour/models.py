from uuid import UUID

from pydantic import BaseModel

from app.location.models import LocationOut
from app.user.models import UserOut


class TourLocationOut(BaseModel):
    location: LocationOut
    index: int | None

    class Config:
        orm_mode = True


class TourOut(BaseModel):
    id: UUID
    user: UserOut
    locations: list[TourLocationOut]

    class Config:
        orm_mode = True
