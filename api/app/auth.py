from datetime import datetime, timedelta
from typing import Any
from uuid import UUID

import jwt
from bcrypt import checkpw

from app.settings import Settings


def get_uuid_from_token(settings: Settings, token: str | None) -> UUID | None:
    """
    Tenta decodificar o token JWT e retornar o UUID correspondente.

    Caso algum dos passos dê errado, retorna `None`.
    """
    try:
        payload = jwt.decode(
            jwt=token, key=settings.SECRET_KEY, algorithms=[settings.ALGORITHM]  # type: ignore
        )
        tknized_uuid: UUID | None = payload.get("sub", None)
    except jwt.PyJWTError:
        return None
    return tknized_uuid


def verify_password(plain_password: str, hashed_password: str) -> bool:
    """
    Checa se `plain_password` equivale a `hashed_password`.
    """
    if hashed_password is None:
        return False
    plain = plain_password.encode("utf-8")
    hashed = hashed_password.encode("utf-8")
    return checkpw(plain, hashed)


def create_access_token(
    settings: Settings, subject: str | Any, expires_delta: timedelta | None = None
) -> str:
    """
    Gera um token JWT.
    """
    expires_delta = (
        expires_delta
        if expires_delta is not None
        else timedelta(minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES)
    )
    expire = datetime.utcnow() + expires_delta
    to_encode = {"exp": expire, "sub": str(subject)}

    encoded_jwt = jwt.encode(
        payload=to_encode, key=settings.SECRET_KEY, algorithm=settings.ALGORITHM  # type: ignore
    )
    return encoded_jwt
