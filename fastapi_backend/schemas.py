from pydantic import BaseModel

class UserSignup(BaseModel):
    name: str
    email: str
    password: str

    class Config:
        orm_mode = True
        
class UserLogin(BaseModel):
    email: str
    password: str

class Token(BaseModel):
    access_token: str
    token_type: str