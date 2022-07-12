from pydantic import BaseSettings, validator


class Settings(BaseSettings):
    """Define configurações de runtime do programa."""

    DB_URL: str
    DB_ECHO: bool = False

    SECRET_KEY: str
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 60

    @validator("DB_URL")
    def change_database_prefix(cls, url: str):  # pylint: disable=no-self-argument
        # Transforma um prefixo de "postgres://" em "postgresql://". O objetivo disso é providenciar suporte à
        # extensão do Postgres do Heroku, a qual define o URL do banco de dados com o prefixo "postgres://", o
        # qual causa erros no carregamento do driver de DB utilizado pelo SQLAlchemy.

        if url.startswith("postgres://"):
            return url.replace("postgres://", "postgresql://", 1)
        return url

    class Config:
        env_file = ".env"
        env_file_encoding = "utf-8"
