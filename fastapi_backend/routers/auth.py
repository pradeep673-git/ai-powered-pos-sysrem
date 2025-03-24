from fastapi import APIRouter, HTTPException
from pydantic import BaseModel

router = APIRouter(prefix="/auth", tags=["auth"])

class UserSignup(BaseModel):
    email: str
    password: str

@router.post("/signup")
async def signup(user: UserSignup):
    # Logic to save user to database (mocked here)
    return {"message": f"User {user.email} created successfully"}
