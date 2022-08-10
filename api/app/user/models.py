from uuid import UUID

import bcrypt
from pydantic import BaseModel, EmailStr, SecretStr, constr

from app.entities.picture import Picture
from app.entities.user import User
from app.picture.models import PictureOut


class AppToken(BaseModel):
    access_token: str
    token_type: str


class UserIn(BaseModel):
    name: constr(strip_whitespace=True, min_length=3, max_length=100)
    email: EmailStr
    phone: constr(strip_whitespace=True, min_length=8, max_length=20)
    password: SecretStr
    profile_picture: str | None

    def to_orm(self) -> User:
        """Retorna uma entidade `User` à partir do model. Os dados devem ser validados
        antes de chamar essa função."""

        password = bcrypt.hashpw(
            self.password.get_secret_value().encode("utf-8"), bcrypt.gensalt()
        )
        user = User(
            name=self.name,
            email=self.email,
            phone=self.phone,
            password=password.decode("utf-8"),
        )
        if self.profile_picture is not None:
            user.profile_picture = Picture(content=self.profile_picture)
        return user


class UserOut(BaseModel):
    id: UUID
    name: str
    email: str
    phone: str | None
    profile_picture: PictureOut | None

    class Config:
        orm_mode = True
