from functools import lru_cache

from pydantic import ValidationError
from sqlalchemy.orm import Session

from app.db import sessionmaker
from app.settings import Settings

# pylint: disable=redefined-outer-name


@lru_cache  # https://fastapi.tiangolo.com/advanced/settings/#settings-in-a-dependency
def settings() -> Settings:
    """Retorna uma instância de `Settings`."""

    try:
        return Settings()
    except ValidationError as ve:
        details = [f'{error["loc"]}: {error["msg"]}' for error in ve.errors()]
        msg = f"Failed to load environment variables: {details}"
        raise RuntimeError(msg) from ve


def db() -> Session:
    """Retorna uma instância de `Session`."""

    db: Session = sessionmaker()

    # Para explicações sobre o bloco try/finally, veja:
    # https://fastapi.tiangolo.com/tutorial/sql-databases/#create-a-dependency
    try:
        yield db
    finally:
        db.close()
