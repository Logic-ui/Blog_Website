from pydantic import BaseModel
from datetime import datetime
from typing import Optional

class NoticeCreate(BaseModel):
    title: str
    content: str

class NoticeUpdate(BaseModel):
    title: Optional[str] = None
    content: Optional[str] = None

class NoticeResponse(BaseModel):
    id: int
    title: str
    content: str
    sender_id: int
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True
