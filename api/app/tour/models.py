from uuid import UUID

from pydantic import BaseModel

from app.location.models import LocationOut
from app.user.models import UserOut


class TourOut(BaseModel):
    id: UUID
    user: UserOut
    locations: LocationOut

    class Config:
        orm_mode = True
