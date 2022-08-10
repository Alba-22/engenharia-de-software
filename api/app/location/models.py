from uuid import UUID

from pydantic import BaseModel

from app.picture.models import PictureOut


class LocationOut(BaseModel):
    id: UUID
    name: str
    formated_address: str
    district: str | None
    city: str
    state: str
    latitude: float
    longitude: float

    pictures: list[PictureOut]

    class Config:
        orm_mode = True
