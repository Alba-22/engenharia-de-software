from uuid import UUID

from fastapi import APIRouter, Depends
from pydantic import conint
from sqlalchemy.orm import Session

from app import depend
from app.entities import User
from app.entities.location import LocationReview
from app.response import CreatedOut, ResponseException
from app.user.depend import auth_user_dependency

from . import location_repo
from .models import LocationOut

router = APIRouter()


@router.get("", response_model=list[LocationOut])
def get_locations(
    city: str | None = None,
    db: Session = Depends(depend.db),
):
    """
    Lista localidades cadastradas, com filtro opcional por cidade.
    """
    return location_repo.list_locations(db, city)


@router.get("/{location_id}", response_model=LocationOut)
def get_location(
    location_id: UUID,
    db: Session = Depends(depend.db),
):
    """
    Retorna localidade cadastrada de id correspondente.

    Erros possíveis:
    - 1 - status HTTP: 404 - Localidade não encontrada.
    """
    if (location := location_repo.by_id(db, location_id)) is None:
        raise ResponseException.not_found(1, "Localidade não encontrada.")
    return location


@router.post("/{location_id}/review", status_code=201, response_model=CreatedOut)
def post_location_review(
    location_id: UUID,
    rate: conint(gt=0, lt=6),
    db: Session = Depends(depend.db),
    user: User = Depends(auth_user_dependency),
):
    """
    Avalia uma localidade.

    Erros possíveis:
    - 1 - status HTTP: 404 - Localidade não encontrada.
    """
    if (location := location_repo.by_id(db, location_id)) is None:
        raise ResponseException.not_found(1, "Localidade não encontrada.")
    location.reviews.append(
        LocationReview(
            user_id=user.id,
            rate=rate,
        )
    )
    db.commit()
    return CreatedOut(id=location_id)
