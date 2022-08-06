from fastapi import Depends
from fastapi.security import OAuth2PasswordBearer
from sqlalchemy.orm import Session

from app.auth import get_uuid_from_token
from app.depend import db, settings
from app.entities import User
from app.response import ResponseException
from app.settings import Settings

from . import user_repo

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/user/login", auto_error=False)

# pylint: disable=redefined-outer-name


def auth_user_dependency(
    settings: Settings = Depends(settings),
    db: Session = Depends(db),
    token: str | None = Depends(oauth2_scheme),
) -> User:
    if (user_id := get_uuid_from_token(settings, token)) is None:
        raise ResponseException.unauthorized(1, "Credenciais inválidas.")
    if (user := user_repo.by_id(db, user_id)) is None:
        raise ResponseException.unauthorized(1, "Credenciais inválidas.")
    return user
