from uuid import UUID

import sqlalchemy as sa
from sqlalchemy.dialects import postgresql

from .base import Base


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

    # picture_id: UUID = sa.Column(sa.ForeignKey("picture.id", ondelete="SET NULL"))
