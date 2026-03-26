from pydantic import BaseModel
from datetime import datetime
from typing import Optional

class BlogCreate(BaseModel):
    title: str
    content: str
    description: str

class BlogUpdate(BaseModel):
    title: Optional[str] = None
    content: Optional[str] = None
    description: Optional[str] = None
    is_published: Optional[bool] = None

class BlogResponse(BaseModel):
    id: int
    title: str
    content: str
    description: str
    author_id: int
    is_published: bool
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True

class BlogWithAuthor(BlogResponse):
    author: Optional['UserResponse'] = None
