from pydantic import BaseSettings


class Settings(BaseSettings):
    DB_CONNECTION: str | None
    DB_HOST: str | None
    DB_PORT: str | None
    DB_DATABASE: str | None
    DB_USERNAME: str | None
    DB_PASSWORD: str | None

    DB_URL: str | None

    SECRET_KEY: str
    ALGORITHM: str
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 60

    class Config:
        env_file = ".env"
        env_file_encoding = "utf-8"


settings = Settings()
