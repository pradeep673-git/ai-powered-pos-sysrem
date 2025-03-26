from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from database import engine, Base
from routers import auth

app = FastAPI()

# Add CORS middleware
origins = [
    "http://localhost:44115/",  # Your Flutter frontend URL
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],  # Allow all methods (GET, POST, OPTIONS, etc.)
    allow_headers=["*"],  # Allow all headers
)

# Create database tables
Base.metadata.create_all(bind=engine)

# Include authentication routes
app.include_router(auth.router)

@app.get("/")
def read_root():
    return {"message": "Welcome to AI-Powered POS System"}
