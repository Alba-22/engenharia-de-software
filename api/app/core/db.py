from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

from app.core.settings import settings

if not settings.DB_URL and not all(
    [
        settings.DB_CONNECTION,
        settings.DB_USERNAME,
        settings.DB_PASSWORD,
        settings.DB_HOST,
        settings.DB_DATABASE,
    ]
):
    raise RuntimeError("Missing environment variables")

SQLALCHEMY_DB_URI = (
    "{}://{}:{}@{}:{}/{}".format(  # pylint: disable=consider-using-f-string
        settings.DB_CONNECTION,
        settings.DB_USERNAME,
        settings.DB_PASSWORD,
        settings.DB_HOST,
        settings.DB_PORT,
        settings.DB_DATABASE,
    )
    if settings.DB_URL is None
    else settings.DB_URL
)

engine = create_engine(SQLALCHEMY_DB_URI, future=True)
SessionLocal = sessionmaker(bind=engine, future=True)


def get_db():
    try:
        db = SessionLocal()
        yield db
    finally:
        if db is not None:
            db.close()
