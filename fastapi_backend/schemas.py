from pydantic import BaseModel

class UserSignup(BaseModel):
    name: str  # New field for user name
    email: str
    password: str

    class Config:
        orm_mode = True  # Allows compatibility with SQLAlchemy models.
