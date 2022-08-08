from uuid import UUID

import sqlalchemy as sa
from sqlalchemy.dialects import postgresql
from sqlalchemy.orm import relationship

from .base import Base
from .location import LocationReview
from .picture import Picture
from .tour import Tour, TourReview


class User(Base):
    id: UUID = sa.Column(
        postgresql.UUID(as_uuid=True),
        primary_key=True,
        server_default=sa.text("gen_random_uuid()"),
    )
    name: str = sa.Column(sa.String(255), nullable=False)
    email: str = sa.Column(sa.String(255), unique=True, nullable=False)
    phone: str = sa.Column(sa.String(255))
    password: str = sa.Column(sa.String(255), nullable=False)

    picture_id: UUID = sa.Column(sa.ForeignKey("picture.id", ondelete="SET NULL"))

    profile_picture: Picture = relationship("Picture", back_populates="user")

    location_reviews: list[LocationReview] = relationship(
        "LocationReview",
        back_populates="user",
        cascade="all, delete",
    )
    tour_reviews: list[TourReview] = relationship(
        "TourReview",
        back_populates="user",
        cascade="all, delete",
    )
    tours: list[Tour] = relationship(
        "Tour",
        back_populates="user",
        cascade="all, delete",
    )
