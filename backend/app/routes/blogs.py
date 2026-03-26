from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from app.database.database import get_db
from app.models.blog import Blog
from app.models.user import User, UserRole
from app.schemas.blog import BlogCreate, BlogUpdate, BlogResponse
from app.routes.users import get_current_user
from typing import List

router = APIRouter(prefix="/api/blogs", tags=["blogs"])

@router.post("/", response_model=BlogResponse)
def create_blog(blog: BlogCreate, current_user: User = Depends(get_current_user), db: Session = Depends(get_db)):
    # Only authors and admins can create blogs
    if current_user.role not in [UserRole.AUTHOR, UserRole.ADMIN]:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="Not authorized to create blog")
    
    db_blog = Blog(
        title=blog.title,
        content=blog.content,
        description=blog.description,
        author_id=current_user.id
    )
    
    db.add(db_blog)
    db.commit()
    db.refresh(db_blog)
    return db_blog

@router.get("/", response_model=List[BlogResponse])
def list_blogs(db: Session = Depends(get_db)):
    blogs = db.query(Blog).filter(Blog.is_published == True).all()
    return blogs

@router.get("/{blog_id}", response_model=BlogResponse)
def get_blog(blog_id: int, db: Session = Depends(get_db)):
    blog = db.query(Blog).filter(Blog.id == blog_id, Blog.is_published == True).first()
    if not blog:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Blog not found")
    return blog

@router.put("/{blog_id}", response_model=BlogResponse)
def update_blog(blog_id: int, blog_update: BlogUpdate, current_user: User = Depends(get_current_user), db: Session = Depends(get_db)):
    blog = db.query(Blog).filter(Blog.id == blog_id).first()
    
    if not blog:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Blog not found")
    
    # Check authorization
    if current_user.id != blog.author_id and current_user.role != UserRole.ADMIN:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="Not authorized to update this blog")
    
    if blog_update.title:
        blog.title = blog_update.title
    if blog_update.content:
        blog.content = blog_update.content
    if blog_update.description:
        blog.description = blog_update.description
    if blog_update.is_published is not None:
        blog.is_published = blog_update.is_published
    
    db.commit()
    db.refresh(blog)
    return blog

@router.delete("/{blog_id}")
def delete_blog(blog_id: int, current_user: User = Depends(get_current_user), db: Session = Depends(get_db)):
    blog = db.query(Blog).filter(Blog.id == blog_id).first()
    
    if not blog:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Blog not found")
    
    # Check authorization
    if current_user.id != blog.author_id and current_user.role != UserRole.ADMIN:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="Not authorized to delete this blog")
    
    db.delete(blog)
    db.commit()
    return {"message": "Blog deleted successfully"}

@router.get("/author/{author_id}", response_model=List[BlogResponse])
def get_author_blogs(author_id: int, db: Session = Depends(get_db)):
    blogs = db.query(Blog).filter(Blog.author_id == author_id, Blog.is_published == True).all()
    if not blogs:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="No blogs found for this author")
    return blogs
