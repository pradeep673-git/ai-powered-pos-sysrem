import sys
from pathlib import Path

# Add the path to your FastAPI application to the system path
sys.path.append(str(Path(__file__).parent.parent))

from fastapi_backend.database import Base
from fastapi_backend.models import User  # Import your models

target_metadata = Base.metadata
