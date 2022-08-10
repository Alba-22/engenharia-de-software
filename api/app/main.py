from fastapi import Depends, FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from sqlalchemy import select
from sqlalchemy.orm import Session

from app import depend
from app.location import router as location_router
from app.response import NO_CONTENT, ResponseException, response_exception_handler
from app.user import router as user_router

app = FastAPI(title="Turistando API", version="Terno Rei")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


app.add_exception_handler(ResponseException, response_exception_handler)


@app.exception_handler(Exception)
def generic_exception_handler(_: Request, _exc: Exception):
    """Torna uma exceção qualquer em uma reposta de Internal Server Error."""

    return JSONResponse(
        status_code=500, content={"message": "Ocorreu um erro no servidor"}
    )


app.include_router(user_router, prefix="/users", tags=["user"])
app.include_router(location_router, prefix="/locations", tags=["location"])


@app.get("/", status_code=204)
def healthcheck(db: Session = Depends(depend.db)):
    """Retorna `204` se o servidor estiver saudável."""

    db.execute(select(1))
    return NO_CONTENT
