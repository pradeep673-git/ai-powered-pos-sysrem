from sqlalchemy import Column, String, Integer
from database import Base

class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, index=True)  # New column for user name
    email = Column(String, unique=True, index=True)
    password = Column(String)
