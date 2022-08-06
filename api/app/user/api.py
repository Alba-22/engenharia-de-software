from uuid import UUID

from fastapi import APIRouter, Depends
from fastapi.security import OAuth2PasswordRequestForm
from sqlalchemy.orm import Session

from app import depend
from app.auth import create_access_token, verify_password
from app.response import CreatedOut, ResponseException
from app.settings import Settings
from app.user.models import UserIn, UserOut

from . import user_repo
from .models import AppToken

router = APIRouter()


@router.post(
    "/login",
    response_model=AppToken,
)
def login(
    settings: Settings = Depends(depend.settings),
    db: Session = Depends(depend.db),
    form_data: OAuth2PasswordRequestForm = Depends(),
):
    """
    Gera um novo token JWT.

    - Erros específicos:
        - 1: 403, "Email ou senha inválidos."
    """
    if (user := user_repo.by_email(db, form_data.username)) is None:
        raise ResponseException.forbidden(1, "Email ou senha inválidos.")
    if verify_password(form_data.password, user.password):
        token = create_access_token(settings, user.id)
        return AppToken(access_token=token, token_type="bearer")  # nosec
    raise ResponseException.forbidden(1, "Email ou senha inválidos.")


@router.post("/new", status_code=201, response_model=CreatedOut)
def post_new_user(payload: UserIn, db: Session = Depends(depend.db)):
    """Cadastra um novo usuário.

    Erros possíveis:
    - 1 - status HTTP: 400 - Email informado já foi cadastrado.
    """

    if user_repo.by_email(db, payload.email) is not None:
        raise ResponseException.bad_request(1, "Email já cadastrado.")

    user = payload.to_orm()
    db.add(user)
    db.commit()

    return CreatedOut(id=user.id)


@router.get("/{user_id}", response_model=UserOut)
def get_user(user_id: UUID, db: Session = Depends(depend.db)):
    """
    Retorna o usuário de id correspondente.

    Erros possíveis:
    - 1 - status HTTP: 404 - Usuário não encontrado.
    """
    if (user := user_repo.by_id(db, user_id)) is None:
        raise ResponseException.not_found(1, "Usuário não encontrado.")
    return user
