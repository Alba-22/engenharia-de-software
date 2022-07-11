from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.core.db import get_db
from app.packages.user.models import UserIn
from app.packages.user.repositories import create_user

user_router = APIRouter()


@user_router.post("")
def register_user(new_user: UserIn, db: Session = Depends(get_db)):
    # TODO
    ...
