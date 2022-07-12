from uuid import UUID

from fastapi import Request, Response
from pydantic import BaseModel
from starlette.responses import JSONResponse

NO_CONTENT = Response(status_code=204)


class ResponseException(Exception):
    """Uma exceção usada para retornar respostas de erro na API."""

    def __init__(self, status_code: int, error_code: int, message: str) -> None:
        super().__init__()
        self.status_code = status_code
        self.error_code = error_code
        self.message = message

    @classmethod
    def bad_request(
        cls: "ResponseException", error_code: int, message: str
    ) -> "ResponseException":
        """Retorna uma instância de `ResponseException` com `status code` 400."""

        return cls(400, error_code, message)


def response_exception_handler(_req: Request, exc: ResponseException):
    """Torna um objeto de ResponseException em uma resposta JSON."""

    return JSONResponse(
        status_code=exc.status_code,
        content={"error_code": exc.error_code, "message": exc.message},
    )


class CreatedOut(BaseModel):
    """Define o output retornado após a criação de novas entidades."""

    id: UUID