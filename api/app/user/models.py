import bcrypt
from pydantic import BaseModel, EmailStr, SecretStr, constr

from app.entities.user import User


class UserIn(BaseModel):
    name: constr(strip_whitespace=True, min_length=3, max_length=100)
    email: EmailStr
    phone: constr(strip_whitespace=True, min_length=8, max_length=20)
    password: SecretStr

    def to_orm(self) -> User:
        """Retorna uma entidade `User` à partir do model. Os dados devem ser validados
        antes de chamar essa função."""

        password = bcrypt.hashpw(
            self.password.get_secret_value().encode("utf-8"), bcrypt.gensalt()
        )
        return User(
            name=self.name,
            email=self.email,
            phone=self.phone,
            password=password.decode("utf-8"),
        )
