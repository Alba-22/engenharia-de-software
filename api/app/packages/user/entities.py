from uuid import UUID
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql

from app.core.entities import Audits, Base


class User(Base, Audits):
    id: UUID = sa.Column(
        postgresql.UUID(as_uuid=True),
        primary_key=True,
        server_default=sa.text("gen_random_uuid()"),
    )
    name = sa.Column(sa.String(255), nullable=False)
    email = sa.Column(sa.String(255), unique=True, nullable=False)
    phone = sa.Column(sa.String(255))
    password = sa.Column(sa.String(255), nullable=False)
    picture_id: UUID = sa.Column(sa.ForeignKey("picture.id", ondelete="SET NULL"))
