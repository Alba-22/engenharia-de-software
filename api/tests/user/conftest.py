import bcrypt
import pytest
from sqlalchemy.orm import Session

from app.auth import create_access_token
from app.depend import settings
from app.entities import Picture, User

testing_password = bcrypt.hashpw("Abcd1234#".encode("utf-8"), bcrypt.gensalt()).decode(
    "utf-8"
)


@pytest.fixture
def user_in_db(database: Session):
    user = User(
        name="Usuário Teste da Silva",
        email="usuario@teste.io",
        phone="912345678",
        password=testing_password,
        profile_picture=Picture(content="url_da_imagem"),
    )
    database.add(user)
    database.commit()
    yield user
    database.delete(user)
    database.commit()


def authorization_header(user: User):
    token = create_access_token(settings(), user.id)
    return {"Authorization": f"Bearer {token}"}
