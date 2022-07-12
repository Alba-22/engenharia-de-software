from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker as SessionMaker

from app.settings import Settings

settings = Settings()

engine = create_engine(settings.DB_URL, future=True, echo=settings.DB_ECHO)
sessionmaker = SessionMaker(bind=engine, future=True)
