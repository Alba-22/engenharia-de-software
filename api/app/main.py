from fastapi import Depends, FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from sqlalchemy import select
from sqlalchemy.orm import Session

from app.core.db import get_db
from app.routers.login import api_router

app = FastAPI(title="Turistando API")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# TODO: exception handler
# @app.exception_handler(ResponseException)
# def response_error_handler(_: Request, exc: ResponseException):
#     return JSONResponse(status_code=exc.code, content=exc.content)


@app.exception_handler(Exception)
def generic_exception_handler(_: Request, _exc: Exception):
    """Torna uma exceção qualquer em uma reposta de Internal Server Error"""
    return JSONResponse(status_code=500, content="Internal Server Error")


app.include_router(api_router)


@app.get("/")
def healthcheck(db: Session = Depends(get_db)):
    db.execute(select(1))
    return {"status": True}
