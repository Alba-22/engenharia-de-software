from uuid import UUID
import bcrypt

from sqlalchemy import select
from sqlalchemy.orm import Session

from app.packages.user.entities import User
from app.packages.user.models import UserIn


def get_user_by_id(db: Session, id_: UUID) -> User | None:
    query = select(User).where(User.id == id_)
    return db.execute(query).scalar()


def get_user_by_email(db: Session, email: str) -> User | None:
    query = select(User).where(User.email == email)
    return db.execute(query).scalar()


def create_user(
    db: Session,
    new_user: UserIn,
    auto_commit: bool = False,
) -> User:
    same_email = get_user_by_email(db, new_user.email)
    if same_email:
        # TODO: considerar usar outro tipo de exception (?)
        raise ValueError("User with this email already exists.")

    password = bcrypt.hashpw(new_user.password.encode("utf-8"), bcrypt.gensalt())

    user = User(
        name=new_user.name,
        email=new_user.email,
        phone=new_user.phone,
        password=password.decode("utf-8"),
    )

    if auto_commit:
        db.add(user)
        db.commit()
    return user
