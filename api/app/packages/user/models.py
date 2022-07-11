from pydantic import (  # pylint: disable=no-name-in-module
    BaseModel,
    EmailStr,
    SecretStr,
    constr,
)


class UserIn(BaseModel):
    name: constr(strip_whitespace=True, min_length=3, max_length=100)
    email: EmailStr
    phone: constr(strip_whitespace=True, min_length=8, max_length=20)
    password: SecretStr
