from fastapi import APIRouter,HTTPException
from pydantic import BaseModel
router = APIRouter()

@router.get("/hello")
def say_hello():
    return {"message": "Hello from another route!"}