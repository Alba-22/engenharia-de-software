from uuid import UUID

from sqlalchemy import select
from sqlalchemy.orm import Session

from app.entities import Tour


def list_tours(db: Session) -> list[Tour]:
    query = select(Tour)
    return db.execute(query).scalars().all()


def by_id(db: Session, id_: UUID) -> Tour | None:
    query = select(Tour).where(Tour.id == id_)
    return db.execute(query).scalar()
