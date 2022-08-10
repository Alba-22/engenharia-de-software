from uuid import UUID

from fastapi import APIRouter, Depends
from pydantic import conint
from sqlalchemy.orm import Session

from app import depend
from app.entities import User
from app.entities.tour import TourReview
from app.response import CreatedOut, ResponseException
from app.user.depend import auth_user_dependency

from . import tour_repo
from .models import TourOut

router = APIRouter()


@router.get("", response_model=list[TourOut])
def get_tours(
    db: Session = Depends(depend.db),
):
    """
    Lista localidades cadastradas, com filtro opcional por cidade.
    """
    return tour_repo.list_tours(db)


@router.get("/{tour_id}", response_model=TourOut)
def get_tour(
    tour_id: UUID,
    db: Session = Depends(depend.db),
):
    """
    Retorna localidade cadastrada de id correspondente.

    Erros possíveis:
    - 1 - status HTTP: 404 - Localidade não encontrada.
    """
    if (tour := tour_repo.by_id(db, tour_id)) is None:
        raise ResponseException.not_found(1, "Localidade não encontrada.")
    return tour


@router.post("/{tour_id}/review", status_code=201, response_model=CreatedOut)
def post_tour_review(
    tour_id: UUID,
    rate: conint(gt=0, lt=6),
    db: Session = Depends(depend.db),
    user: User = Depends(auth_user_dependency),
):
    """
    Avalia uma localidade.

    Erros possíveis:
    - 1 - status HTTP: 404 - Localidade não encontrada.
    """
    if (tour := tour_repo.by_id(db, tour_id)) is None:
        raise ResponseException.not_found(1, "Localidade não encontrada.")
    tour.reviews.append(
        TourReview(
            user_id=user.id,
            rate=rate,
        )
    )
    db.commit()
    return CreatedOut(id=tour_id)
