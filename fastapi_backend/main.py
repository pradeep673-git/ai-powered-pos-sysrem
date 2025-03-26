# from fastapi import FastAPI, HTTPException, Depends
# from sqlalchemy.orm import Session
# from pydantic import BaseModel, EmailStr
# from passlib.context import CryptContext
# from models import Base, User
# from database import engine, get_db

# # Initialize FastAPI app and create database tables
# app = FastAPI()
# Base.metadata.create_all(bind=engine)

# # Password hashing context
# pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

# # Pydantic model for user input validation
# class UserCreate(BaseModel):
#     name: str
#     email: EmailStr
#     password: str

# @app.post("/auth/signup")
# def signup(user: UserCreate, db: Session = Depends(get_db)):
#     # Check if email already exists
#     existing_user = db.query(User).filter(User.email == user.email).first()
#     if existing_user:
#         raise HTTPException(status_code=400, detail="Email already registered")

#     # Hash the password before storing it in the database
#     hashed_password = pwd_context.hash(user.password)

#     # Create new user instance and save it to the database
#     new_user = User(name=user.name, email=user.email, hashed_password=hashed_password)
#     db.add(new_user)
#     db.commit()
#     db.refresh(new_user)

#     return {"message": "User created successfully"}
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from database import engine, Base  # Import database setup
from routers import auth  # Import authentication routes

app = FastAPI()

origins = [
    "http://localhost:8000",  # Your Flutter frontend URL
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,  # Allow requests from these origins
    allow_credentials=True,
    allow_methods=["*"],  # Allow all HTTP methods
    allow_headers=["*"],  # Allow all headers
)

# Create database tables if they don't exist
Base.metadata.create_all(bind=engine)

# Include authentication routes
app.include_router(auth.router)

@app.get("/")
def read_root():
    return {"message": "Welcome to AI-Powered POS System"}
