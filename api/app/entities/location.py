from __future__ import annotations

from typing import TYPE_CHECKING
from uuid import UUID

import sqlalchemy as sa
from sqlalchemy.dialects import postgresql
from sqlalchemy.orm import relationship

from .base import Base

if TYPE_CHECKING:
    from .picture import Picture
    from .tour import TourLocation
    from .user import User

location_picture_table = sa.Table(
    "location_picture",
    Base.metadata,  # type: ignore # pylint: disable=no-member
    sa.Column(
        "picture_id",
        sa.ForeignKey("picture.id", ondelete="CASCADE"),
        primary_key=True,
    ),
    sa.Column(
        "location_id",
        sa.ForeignKey("location.id", ondelete="CASCADE"),
        primary_key=True,
    ),
)


class Location(Base):
    id: UUID = sa.Column(
        postgresql.UUID(as_uuid=True),
        primary_key=True,
        server_default=sa.text("gen_random_uuid()"),
    )
    name: str = sa.Column(sa.String(255), nullable=False)
    formated_address: str = sa.Column(sa.String(255), nullable=False)
    district: str = sa.Column(sa.String(255))
    city: str = sa.Column(sa.String(255), nullable=False)
    state: str = sa.Column(sa.String(255), nullable=False)
    latitude: float = sa.Column(sa.Float, nullable=False)
    longitude: float = sa.Column(sa.Float, nullable=False)

    pictures: list["Picture"] = relationship(
        "Picture",
        secondary=location_picture_table,
        back_populates="locations",
    )
    reviews: list[LocationReview] = relationship(
        "LocationReview",
        back_populates="location",
        cascade="all, delete",
    )
    tours: list["TourLocation"] = relationship(
        "TourLocation",
        back_populates="location",
        cascade="all, delete",
    )


class LocationReview(Base):
    location_id: UUID = sa.Column(
        sa.ForeignKey("location.id", ondelete="CASCADE"), primary_key=True
    )
    user_id: UUID = sa.Column(
        sa.ForeignKey("user.id", ondelete="CASCADE"), primary_key=True
    )
    rate: int = sa.Column(sa.Integer, nullable=False)

    location: Location = relationship("Location", back_populates="reviews")
    user: "User" = relationship("User", back_populates="location_reviews")
