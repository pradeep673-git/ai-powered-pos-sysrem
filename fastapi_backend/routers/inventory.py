# # fastapi_backend/routers/inventory.py

# from fastapi import APIRouter, Depends
# from sqlalchemy.orm import Session
# from database import get_db
# from crud import add_inventory_item, remove_inventory_item

# router = APIRouter()

# @router.post("/inventory/add")
# async def add_item(name: str, quantity: int, unit: str, db: Session = Depends(get_db)):
#     return add_inventory_item(db=db, name=name, quantity=quantity, unit=unit)

# @router.post("/inventory/remove")
# async def remove_item(name: str, quantity: int, db: Session = Depends(get_db)):
#     return remove_inventory_item(db=db, name=name, quantity=quantity)
# fastapi_backend/routers/inventory.py

from fastapi import APIRouter, Depends
from pydantic import BaseModel
from sqlalchemy.orm import Session
from database import get_db
from crud import add_inventory_item, remove_inventory_item

router = APIRouter()

class InventoryItem(BaseModel):
    name: str
    quantity: int
    unit: str

class RemoveInventoryItem(BaseModel):
    name: str
    quantity: int



@router.post("/inventory/add")
async def add_item(item: InventoryItem, db: Session = Depends(get_db)):
    """
    Add an item to the inventory.
    """
    return add_inventory_item(db=db, name=item.name, quantity=item.quantity, unit=item.unit)

@router.post("/inventory/remove")
async def remove_item(item: RemoveInventoryItem, db: Session = Depends(get_db)):
    """
    Remove an item from the inventory.
    """
    return remove_inventory_item(db=db, name=item.name, quantity=item.quantity)