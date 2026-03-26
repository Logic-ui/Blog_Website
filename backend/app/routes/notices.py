from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from app.database.database import get_db
from app.models.notice import Notice
from app.models.user import User, UserRole
from app.schemas.notice import NoticeCreate, NoticeUpdate, NoticeResponse
from app.routes.users import get_current_user
from typing import List

router = APIRouter(prefix="/api/notices", tags=["notices"])

@router.post("/", response_model=NoticeResponse)
def create_notice(notice: NoticeCreate, current_user: User = Depends(get_current_user), db: Session = Depends(get_db)):
    # Only admins can create notices
    if current_user.role != UserRole.ADMIN:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="Only admins can create notices")
    
    db_notice = Notice(
        title=notice.title,
        content=notice.content,
        sender_id=current_user.id
    )
    
    db.add(db_notice)
    db.commit()
    db.refresh(db_notice)
    return db_notice

@router.get("/", response_model=List[NoticeResponse])
def list_notices(db: Session = Depends(get_db)):
    notices = db.query(Notice).all()
    return notices

@router.get("/{notice_id}", response_model=NoticeResponse)
def get_notice(notice_id: int, db: Session = Depends(get_db)):
    notice = db.query(Notice).filter(Notice.id == notice_id).first()
    if not notice:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Notice not found")
    return notice

@router.put("/{notice_id}", response_model=NoticeResponse)
def update_notice(notice_id: int, notice_update: NoticeUpdate, current_user: User = Depends(get_current_user), db: Session = Depends(get_db)):
    # Only admins can update notices
    if current_user.role != UserRole.ADMIN:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="Only admins can update notices")
    
    notice = db.query(Notice).filter(Notice.id == notice_id).first()
    
    if not notice:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Notice not found")
    
    if notice_update.title:
        notice.title = notice_update.title
    if notice_update.content:
        notice.content = notice_update.content
    
    db.commit()
    db.refresh(notice)
    return notice

@router.delete("/{notice_id}")
def delete_notice(notice_id: int, current_user: User = Depends(get_current_user), db: Session = Depends(get_db)):
    # Only admins can delete notices
    if current_user.role != UserRole.ADMIN:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="Only admins can delete notices")
    
    notice = db.query(Notice).filter(Notice.id == notice_id).first()
    
    if not notice:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Notice not found")
    
    db.delete(notice)
    db.commit()
    return {"message": "Notice deleted successfully"}
