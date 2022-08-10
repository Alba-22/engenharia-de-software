from uuid import UUID

from sqlalchemy import select
from sqlalchemy.orm import Session

from app.entities import Location


def list_locations(db: Session, city: str | None) -> list[Location]:
    query = select(Location)
    if city:
        query = query.where(Location.city == city)
    return db.execute(query).scalars().all()


def by_id(db: Session, id_: UUID) -> Location | None:
    query = select(Location).where(Location.id == id_)
    return db.execute(query).scalar()
