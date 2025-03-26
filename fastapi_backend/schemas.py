from pydantic import BaseModel

class UserSignup(BaseModel):
    name: str
    email: str
    password: str

    class Config:
        orm_mode = True
