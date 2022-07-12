import re

import sqlalchemy as sa
from sqlalchemy.orm import as_declarative, declared_attr


@as_declarative()
class Base:
    __name__: str

    # Generate __tablename__ automatically

    @declared_attr
    def __tablename__(cls) -> str:
        # pylint: disable=no-self-argument
        # Camel case to snake case
        return re.sub(r"(?<!^)(?=[A-Z])", "_", cls.__name__).lower()


class Audits:
    date_created = sa.Column(
        sa.TIMESTAMP(timezone=True), server_default=sa.sql.func.now()
    )
    date_updated = sa.Column(
        sa.TIMESTAMP(timezone=True),
        server_default=sa.sql.func.now(),
        onupdate=sa.sql.func.now(),
    )
