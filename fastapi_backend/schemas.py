from pydantic import BaseModel

class UserSignup(BaseModel):
    email: str
    password: str
    
    class Config:
        orm_mode = True
