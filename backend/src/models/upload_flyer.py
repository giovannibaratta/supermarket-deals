from pydantic import BaseModel


class RawFlyer(BaseModel):
    file: bytes
    filename: str
