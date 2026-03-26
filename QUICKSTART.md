# ⚡ Quick Start Guide

## 🎯 Get Running in 10 Minutes

### Prerequisites
- Python 3.8+
- Node.js 14+
- Git (optional)

---

## 🏃 Backend Setup (5 minutes)

```bash
# 1. Open terminal in backend folder
cd Blog-website/backend

# 2. Create virtual environment
python -m venv venv

# 3. Activate it
# Windows:
venv\Scripts\activate
# macOS/Linux:
source venv/bin/activate

# 4. Install dependencies
pip install -r requirements.txt

# 5. Run server
python main.py
```

✅ Backend running at `http://localhost:8000`
📖 API Docs at `http://localhost:8000/docs`

---

## 🏃 Frontend Setup (5 minutes)

```bash
# 1. Open new terminal in frontend folder
cd Blog-website/frontend

# 2. Install dependencies
npm install

# 3. Start development server
npm start
```

✅ Frontend running at `http://localhost:3000`

---

## 🧪 Test It Out

### 1. Register a User
- Click "Register" button
- Fill in form with "Author" role
- Click Register

### 2. Login
- Click "Login"
- Use credentials from registration
- Click Login

### 3. Create a Blog
- Click "Write Blog" in navigation
- Fill in title, description, and content
- Click "Publish Blog"

### 4. Read Your Blog
- Go to Home page
- Click "Read More" on your blog card
- See full blog content

### 5. Try Admin (Backend Magic)

Open Python in backend folder:
```python
from app.database.database import SessionLocal
from app.models.user import User, UserRole
from app.auth import get_password_hash

db = SessionLocal()
admin = User(
    username="admin",
    email="admin@admin.com",
    full_name="Admin User",
    hashed_password=get_password_hash("admin123"),
    role=UserRole.ADMIN
)
db.add(admin)
db.commit()
```

Then login as admin on frontend to access Admin Dashboard!

---

## 📋 What Each Role Can Do

### 👤 Reader
- ✅ Browse all blogs
- ✅ Read full blog posts
- ✅ View author profiles
- ❌ Create blogs

### ✍️ Author  
- ✅ Do everything Reader can
- ✅ Create blog posts
- ✅ Edit own posts
- ✅ Delete own posts
- ❌ Delete others' posts

### 👨‍💼 Admin
- ✅ Do everything
- ✅ Create announcements
- ✅ Delete any blog
- ✅ View all users

---

## 🔑 Test Credentials

### Test Author Account
- Username: `testauthor`
- Password: `test123`
- Role: Author

### Test Admin Account
- Username: `admin`
- Password: `admin123`
- Role: Admin

(Create these via frontend registration or backend script)

---

## 🚀 Key Features

✨ **Authentication**: JWT tokens secure endpoints
🔐 **Role-Based Access**: Different permissions per role
📝 **Blogs**: Create, read, update, delete blog posts
📢 **Notices**: Admin can post announcements
👥 **Users**: User management and profiles
🎨 **Modern UI**: Clean, responsive React interface

---

## 📁 File Structure

```
Blog-website/
├── backend/           # FastAPI server
│   ├── app/
│   │   ├── models/    # Database models
│   │   ├── routes/    # API endpoints
│   │   ├── schemas/   # Data validation
│   │   └── auth.py    # Authentication
│   └── main.py        # Start server here
└── frontend/          # React app
    ├── src/
    │   ├── pages/     # React pages
    │   ├── components/# React components
    │   └── services/  # API calls
    └── package.json
```

---

## 🌐 API Endpoints

### Users
- `POST /api/users/register` - Register
- `POST /api/users/login` - Login
- `GET /api/users/me` - Current user

### Blogs
- `POST /api/blogs/` - Create
- `GET /api/blogs/` - List
- `GET /api/blogs/{id}` - Detail
- `DELETE /api/blogs/{id}` - Delete

### Notices
- `POST /api/notices/` - Create (admin)
- `GET /api/notices/` - List

---

## 🐛 Troubleshooting

### Port Already in Use
```bash
# Change port in main.py or use:
python -m uvicorn app.main:app --port 8001
```

### Database Error
```bash
# Delete and recreate:
rm blog.db
python main.py
```

### CORS Error
Backend already has CORS enabled. Check frontend API URL.

---

## 📚 Full Documentation

- Backend: `Blog-website/backend/README.md`
- Frontend: `Blog-website/frontend/README.md`
- Main: `Blog-website/README.md`

---

## ✅ Next Steps

1. **Explore the code** - It's well-commented
2. **Try all features** - Create blogs, manage as admin
3. **Extend it** - Add comments, search, categories, etc.
4. **Deploy** - Host on AWS, Vercel, Heroku, etc.

---

Happy Blogging! 📝✨
