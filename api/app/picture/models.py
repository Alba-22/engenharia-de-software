from pydantic import BaseModel


class PictureOut(BaseModel):
    content: str

    class Config:
        orm_mode = True
