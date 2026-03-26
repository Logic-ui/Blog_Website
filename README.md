# Blog Website - Complete Setup Guide

## 📋 Project Overview

This is a full-stack blog website with:
- **Backend**: FastAPI with SQLAlchemy ORM
- **Frontend**: React with React Router
- **Database**: SQLite (easily switchable to PostgreSQL)
- **Authentication**: JWT Token-based
- **Roles**: Admin, Author, Reader

---

## 🎯 Features

### 📖 For Readers
- Browse all published blogs
- Read blog posts with author information
- User authentication

### ✍️ For Authors
- Create and upload blogs
- Edit their own blogs
- Publish/unpublish blogs
- View all their published blogs

### 👨‍💼 For Admins
- View all blogs and users
- Delete blogs
- Create and manage notices/announcements
- Delete user accounts if needed

---

## 🛠️ Technologies Used

### Backend
- **FastAPI** - Modern Python web framework
- **SQLAlchemy** - ORM for database operations
- **Pydantic** - Data validation
- **SQLite** - Lightweight database
- **JWT** - Authentication tokens
- **Passlib & Bcrypt** - Password hashing

### Frontend
- **React 18** - UI library
- **React Router DOM** - Client-side routing
- **Axios** - HTTP client
- **CSS** - Styling

---

## 📁 Directory Structure

```
Blog-website/
├── backend/
│   ├── app/
│   │   ├── models/
│   │   │   ├── __init__.py
│   │   │   ├── user.py        # User model
│   │   │   ├── blog.py        # Blog model
│   │   │   └── notice.py      # Notice model
│   │   ├── routes/
│   │   │   ├── users.py       # User API endpoints
│   │   │   ├── blogs.py       # Blog API endpoints
│   │   │   └── notices.py     # Notice API endpoints
│   │   ├── schemas/
│   │   │   ├── user.py        # User validation schemas
│   │   │   ├── blog.py        # Blog validation schemas
│   │   │   └── notice.py      # Notice validation schemas
│   │   ├── database/
│   │   │   └── database.py    # DB configuration
│   │   └── auth.py            # Authentication utilities
│   ├── main.py                # FastAPI app entry
│   ├── requirements.txt       # Python dependencies
│   └── .env                   # Environment variables
│
└── frontend/
    ├── public/
    │   └── index.html
    ├── src/
    │   ├── components/
    │   │   ├── Header.js
    │   │   └── BlogCard.js
    │   ├── pages/
    │   │   ├── Home.js
    │   │   ├── Login.js
    │   │   ├── Register.js
    │   │   ├── BlogDetail.js
    │   │   ├── CreateBlog.js
    │   │   └── Admin.js
    │   ├── services/
    │   │   └── api.js         # API client
    │   ├── context/
    │   │   └── AuthContext.js # Auth state management
    │   ├── styles/
    │   │   ├── index.css
    │   │   ├── Header.css
    │   │   ├── Auth.css
    │   │   ├── Home.css
    │   │   ├── Blog.css
    │   │   ├── CreateBlog.css
    │   │   └── Admin.css
    │   ├── App.js
    │   └── index.js
    └── package.json
```

---

## 🚀 Installation & Setup

### Prerequisites
- Python 3.8+
- Node.js 14+
- npm or yarn

### 1️⃣ Backend Setup

#### Step 1: Navigate to backend directory
```bash
cd Blog-website/backend
```

#### Step 2: Create virtual environment
```bash
python -m venv venv
```

#### Step 3: Activate virtual environment
```bash
# On Windows
venv\Scripts\activate

# On macOS/Linux
source venv/bin/activate
```

#### Step 4: Install dependencies
```bash
pip install -r requirements.txt
```

#### Step 5: Run the backend server
```bash
python main.py
```

The backend will start at `http://localhost:8000`

**API Documentation**: Visit `http://localhost:8000/docs` (Swagger UI)

### 2️⃣ Frontend Setup

#### Step 1: Navigate to frontend directory
```bash
cd Blog-website/frontend
```

#### Step 2: Install dependencies
```bash
npm install
```

#### Step 3: Start development server
```bash
npm start
```

The frontend will open at `http://localhost:3000`

---

## 🔑 Authentication

### Registration
1. Click "Register" on the home page
2. Enter username, email, full name, and password
3. Choose role: **Reader** or **Author**
4. Click Register

### Login
1. Click "Login" on the home page
2. Enter username and password
3. Token is saved to localStorage

---

## 💡 How to Use

### 📖 As a Reader
1. **Browse Blogs**: Visit homepage to see all published blogs
2. **Read Blog**: Click "Read More" on any blog card to view full content
3. **View Author**: See author info on blog detail page

### ✍️ As an Author
1. Register with "Author" role
2. Click "Write Blog" in navigation
3. Fill in title, description, and content
4. Click "Publish Blog"
5. Your blog appears on homepage

### 👨‍💼 As an Admin
1. Register first as normal user (or backend admin setup)
2. Click "Admin" in navigation
3. **Manage Blogs**: View and delete any blog
4. **Create Notices**: Post announcements for users
5. **View Users**: See all registered users

---

## 📡 API Endpoints

### User Endpoints
- `POST /api/users/register` - Register new user
- `POST /api/users/login` - User login
- `GET /api/users/me` - Get current user (requires auth)
- `GET /api/users/` - List all users
- `GET /api/users/{user_id}` - Get user details
- `PUT /api/users/{user_id}` - Update user
- `DELETE /api/users/{user_id}` - Delete user (admin only)

### Blog Endpoints
- `POST /api/blogs/` - Create blog (author/admin only)
- `GET /api/blogs/` - List published blogs
- `GET /api/blogs/{blog_id}` - Get blog details
- `PUT /api/blogs/{blog_id}` - Update blog (author/admin)
- `DELETE /api/blogs/{blog_id}` - Delete blog (author/admin)
- `GET /api/blogs/author/{author_id}` - Get author's blogs

### Notice Endpoints
- `POST /api/notices/` - Create notice (admin only)
- `GET /api/notices/` - List all notices
- `GET /api/notices/{notice_id}` - Get notice details
- `PUT /api/notices/{notice_id}` - Update notice (admin only)
- `DELETE /api/notices/{notice_id}` - Delete notice (admin only)

---

## 🔐 Admin Setup (Backend)

To manually create an admin user, run Python shell in backend:

```python
from app.database.database import SessionLocal
from app.models.user import User, UserRole
from app.auth import get_password_hash

db = SessionLocal()

admin = User(
    username="admin",
    email="admin@example.com",
    full_name="Admin User",
    hashed_password=get_password_hash("admin123"),
    role=UserRole.ADMIN
)

db.add(admin)
db.commit()
print("Admin user created!")
```

---

## 🗄️ Database

### Models

#### User
```
- id: Integer (PK)
- username: String
- email: String
- full_name: String
- hashed_password: String
- role: Enum (admin, author, reader)
- is_active: Boolean
- created_at: DateTime
- updated_at: DateTime
```

#### Blog
```
- id: Integer (PK)
- title: String
- content: Text
- description: String
- author_id: Foreign Key
- is_published: Boolean
- created_at: DateTime
- updated_at: DateTime
```

#### Notice
```
- id: Integer (PK)
- title: String
- content: Text
- sender_id: Foreign Key
- created_at: DateTime
- updated_at: DateTime
```

---

## 🔄 Workflow Examples

### Example 1: Create and Publish a Blog
1. **Register** as Author
2. Go to "Write Blog"
3. Fill in details and publish
4. Blog automatically appears on homepage

### Example 2: Admin Deletes a Blog
1. Login as Admin
2. Go to Admin Panel
3. View all blogs
4. Click Delete on any blog

### Example 3: Browse and Read Blogs
1. Visit homepage (no login needed)
2. See all published blogs
3. Click any blog to read full content
4. See author details

---

## ⚙️ Configuration

### Backend (.env)
```
DATABASE_URL=sqlite:///./blog.db
SECRET_KEY=your-secret-key-change-in-production
```

For **Production Database** (PostgreSQL):
```
DATABASE_URL=postgresql://user:password@localhost/blog_db
```

### Frontend (API URL)
Edit `frontend/src/services/api.js`:
```javascript
const API_BASE_URL = 'http://localhost:8000/api';
```

---

## 🐛 Troubleshooting

### Backend Issues

**Port 8000 already in use**
```bash
# Change port in main.py or use:
uvicorn app.main:app --port 8001
```

**Database errors**
```bash
# Delete SQLite file and restart
rm blog.db
python main.py
```

### Frontend Issues

**Port 3000 already in use**
```bash
# Use different port:
PORT=3001 npm start
```

**CORS errors**
- Backend CORS is enabled for all origins
- Check that frontend URL matches in settings

---

## 📦 Production Deployment

### Backend (Gunicorn)
```bash
pip install gunicorn
gunicorn -w 4 -k uvicorn.workers.UvicornWorker app.main:app
```

### Frontend (Build)
```bash
npm run build
```

---

## 🤝 Contributing

Feel free to extend this project with:
- Comments on blogs
- Search functionality
- Categories/Tags
- User profiles
- Email notifications
- Image uploads

---

## 📝 License

This project is open source and available under MIT License.

---

## 📞 Support

For issues or questions, please check the code comments or reach out!

Happy blogging! 📝✨
