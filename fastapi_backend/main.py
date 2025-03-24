from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from routers import auth  # Adjust the import based on your structure

app = FastAPI()

# CORS configuration (adjust origins as needed)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Change this to your frontend origin if needed
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include the auth router
app.include_router(auth.router)

@app.get("/")
def read_root():
    return {"message": "Welcome to the AI-Powered POS System"}
