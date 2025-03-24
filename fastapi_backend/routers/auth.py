from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from database import get_db
from . import models, schemas
from passlib.context import CryptContext

router = APIRouter(prefix="/auth", tags=["auth"])

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

@router.post("/signup", response_model=schemas.UserSignup)
async def create_user(user: schemas.UserSignup, db: Session = Depends(get_db)):
    db_user = db.query(models.User).filter(models.User.email == user.email).first()
    if db_user:
        raise HTTPException(status_code=400, detail="Email already registered")
    
    hashed_password = pwd_context.hash(user.password)
    db_user = models.User(name=user.name, email=user.email, password=hashed_password)  # Include name here
    
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    
    return {"message": f"User {db_user.name} created successfully"}
