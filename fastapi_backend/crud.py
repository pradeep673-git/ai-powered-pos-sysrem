# fastapi_backend/crud.py

from sqlalchemy.orm import Session
from models import InventoryItem

def add_inventory_item(db: Session, name: str, quantity: int, unit: str):
    item = InventoryItem(name=name, quantity=quantity, unit=unit)
    db.add(item)
    db.commit()
    db.refresh(item)
    return item

def remove_inventory_item(db: Session, name: str, quantity: int):
    item = db.query(InventoryItem).filter(InventoryItem.name == name).first()
    if item:
        item.quantity -= quantity
        if item.quantity <= 0:
            db.delete(item)
        db.commit()
        return item
    return None
