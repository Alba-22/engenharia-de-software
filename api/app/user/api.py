from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app import depend
from app.response import CreatedOut, ResponseException
from app.user.models import UserIn

from . import user_repo

router = APIRouter()


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
