# from fastapi import APIRouter, HTTPException, Depends
# from sqlalchemy.orm import Session
# from database import get_db  # Import database connection setup
# from models import User      # Import SQLAlchemy User model
# from schemas import UserSignup  # Import Pydantic schema for signup
# from passlib.context import CryptContext

# router = APIRouter(prefix="/auth", tags=["auth"])

# pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

# @router.post("/signup", response_model=UserSignup)
# async def create_user(user: UserSignup, db: Session = Depends(get_db)):
#     db_user = db.query(User).filter(User.email == user.email).first()
#     if db_user:
#         raise HTTPException(status_code=400, detail="Email already registered")
    
#     hashed_password = pwd_context.hash(user.password)
#     new_user = User(name=user.name, email=user.email, password=hashed_password)
    
#     db.add(new_user)
#     db.commit()
#     db.refresh(new_user)
    
#     return new_user

# fastapi_backend/routers/auth.py

from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from database import get_db
from models import User
from schemas import UserSignup
from passlib.context import CryptContext
from fastapi.responses import JSONResponse

router = APIRouter(prefix="/auth", tags=["auth"])

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

@router.options("/signup")
async def options_signup():
    return JSONResponse(
        status_code=200,
        headers={
            "Access-Control-Allow-Origin": "http://localhost:44115",
            "Access-Control-Allow-Methods": "POST, OPTIONS",
            "Access-Control-Allow-Headers": "*",
        },
        content={},
    )

@router.post("/signup", response_model=UserSignup)
async def create_user(user: UserSignup, db: Session = Depends(get_db)):
    db_user = db.query(User).filter(User.email == user.email).first()
    if db_user:
        raise HTTPException(status_code=400, detail="Email already registered")
    
    hashed_password = pwd_context.hash(user.password)
    new_user = User(name=user.name, email=user.email, password=hashed_password)
    
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    
    return new_user
