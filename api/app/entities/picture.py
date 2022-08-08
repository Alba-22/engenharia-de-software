from typing import TYPE_CHECKING, Optional
from uuid import UUID

import sqlalchemy as sa
from sqlalchemy.dialects import postgresql
from sqlalchemy.orm import relationship

from .base import Base
from .location import Location, location_picture_table

if TYPE_CHECKING:
    from .user import User


class Picture(Base):
    id: UUID = sa.Column(
        postgresql.UUID(as_uuid=True),
        primary_key=True,
        server_default=sa.text("gen_random_uuid()"),
    )
    content: str = sa.Column(sa.String(255), nullable=False)

    user: Optional["User"] = relationship(
        "User", back_populates="profile_picture", uselist=False
    )
    locations: list[Location] = relationship(
        "Location", secondary=location_picture_table, back_populates="picturess"
    )
