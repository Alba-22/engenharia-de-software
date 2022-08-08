from __future__ import annotations

from typing import TYPE_CHECKING
from uuid import UUID

import sqlalchemy as sa
from sqlalchemy.dialects import postgresql
from sqlalchemy.orm import relationship

from .base import Base
from .location import Location

if TYPE_CHECKING:
    from .user import User


class Tour(Base):
    id: UUID = sa.Column(
        postgresql.UUID(as_uuid=True),
        primary_key=True,
        server_default=sa.text("gen_random_uuid()"),
    )
    user_id: UUID = sa.Column(sa.ForeignKey("user.id", ondelete="CASCADE"))
    location_image_index = sa.Column(sa.Integer, nullable=False)

    user: "User" = relationship("User", back_populates="tours")
    reviews: list[TourReview] = relationship(
        "TourReview",
        back_populates="tour",
        cascade="all, delete",
    )
    locations: list[TourLocation] = relationship(
        "TourLocation",
        back_populates="tour",
        cascade="all, delete",
    )


class TourReview(Base):
    tour_id: UUID = sa.Column(
        sa.ForeignKey("tour.id", ondelete="CASCADE"), primary_key=True
    )
    user_id: UUID = sa.Column(
        sa.ForeignKey("user.id", ondelete="CASCADE"), primary_key=True
    )
    rate: int = sa.Column(sa.Integer, nullable=False)

    tour: Tour = relationship("Tour", back_populates="reviews")
    user: "User" = relationship("User", back_populates="tour_reviews")


class TourLocation(Base):
    tour_id: UUID = sa.Column(
        sa.ForeignKey("tour.id", ondelete="CASCADE"), primary_key=True
    )
    location_id: UUID = sa.Column(
        sa.ForeignKey("location.id", ondelete="CASCADE"), primary_key=True
    )
    index: int = sa.Column(
        sa.Integer,
    )
    location: Location = relationship("Location", back_populates="tours")
    tour: Tour = relationship("Tour", back_populates="locations")
