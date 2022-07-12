from uuid import UUID

from sqlalchemy import select
from sqlalchemy.orm import Session

from app.entities import User


def by_id(db: Session, id_: UUID) -> User | None:
    query = select(User).where(User.id == id_)
    return db.execute(query).scalar()


def by_email(db: Session, email: str) -> User | None:
    query = select(User).where(User.email == email)
    return db.execute(query).scalar()
