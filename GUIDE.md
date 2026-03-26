# 📚 Blog Website - Complete Project Guide

## 🎯 Project Overview

This is a **full-stack blog website** with:

| Component | Technology | Features |
|-----------|-----------|----------|
| **Backend** | FastAPI | RESTful API, JWT Auth, SQLite/PostgreSQL |
| **Frontend** | React | Modern UI, React Router, Axios |
| **Database** | SQLAlchemy | ORM, User roles, Relationships |
| **Auth** | JWT + Bcrypt | Secure token-based authentication |

---

## 📋 System Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     React Frontend                          │
│  (localhost:3000)                                           │
│  ┌──────────────┬──────────────┬──────────────┐             │
│  │   Home       │   BlogDetail │   Admin      │             │
│  │   Login      │   CreateBlog │   User Prof. │             │
│  └──────────────┴──────────────┴──────────────┘             │
└──────────────────────┬──────────────────────────────────────┘
                       │ HTTP/Axios
                       │
┌──────────────────────▼──────────────────────────────────────┐
│                  FastAPI Backend                            │
│  (localhost:8000)                                           │
│  ┌──────────────┬──────────────┬──────────────┐             │
│  │  /users      │  /blogs      │  /notices    │             │
│  │  endpoints   │  endpoints   │  endpoints   │             │
│  └──────────────┴──────────────┴──────────────┘             │
└──────────────────────┬──────────────────────────────────────┘
                       │ SQLAlchemy ORM
                       │
┌──────────────────────▼──────────────────────────────────────┐
│                   SQLite Database                           │
│  (blog.db)                                                  │
│  ┌──────────────┬──────────────┬──────────────┐             │
│  │  users       │  blogs       │  notices     │             │
│  │  table       │  table       │  table       │             │
│  └──────────────┴──────────────┴──────────────┘             │
└─────────────────────────────────────────────────────────────┘
```

---

## 🔑 Database Schema

### Users Table
```sql
CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    username VARCHAR UNIQUE NOT NULL,
    email VARCHAR UNIQUE NOT NULL,
    full_name VARCHAR NOT NULL,
    hashed_password VARCHAR NOT NULL,
    role ENUM('admin', 'author', 'reader') DEFAULT 'reader',
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);
```

### Blogs Table
```sql
CREATE TABLE blogs (
    id INTEGER PRIMARY KEY,
    title VARCHAR NOT NULL,
    content TEXT NOT NULL,
    description VARCHAR,
    author_id INTEGER FOREIGN KEY REFERENCES users(id),
    is_published BOOLEAN DEFAULT true,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);
```

### Notices Table
```sql
CREATE TABLE notices (
    id INTEGER PRIMARY KEY,
    title VARCHAR NOT NULL,
    content TEXT NOT NULL,
    sender_id INTEGER FOREIGN KEY REFERENCES users(id),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);
```

---

## 🚀 Quick Start

### 1️⃣ Backend Setup (Terminal 1)

```bash
cd Blog-website/backend
python -m venv venv
source venv/bin/activate  # or venv\Scripts\activate on Windows
pip install -r requirements.txt
python main.py
```

✅ Server at: http://localhost:8000
📖 Docs at: http://localhost:8000/docs

### 2️⃣ Frontend Setup (Terminal 2)

```bash
cd Blog-website/frontend
npm install
npm start
```

✅ App at: http://localhost:3000

---

## 👥 User Roles & Permissions

### 📖 Reader
```
✅ Browse published blogs
✅ Read full blog content
✅ View author profiles
✅ Register and login
❌ Cannot create blogs
❌ Cannot manage content
```

### ✍️ Author
```
✅ All Reader permissions
✅ Create new blog posts
✅ Edit own blogs
✅ Delete own blogs
✅ View own blog statistics
❌ Cannot delete other's blogs
❌ Cannot manage users
```

### 👨‍💼 Admin
```
✅ All Author permissions
✅ Create announcements/notices
✅ Delete any blog post
✅ View all users and blogs
✅ Manage user accounts
✅ View system statistics
```

---

## 📊 API Endpoints by Category

### 🔐 Authentication (No token needed for register)

| Method | Endpoint | Auth | Purpose |
|--------|----------|------|---------|
| POST | `/api/users/register` | ❌ | Create account |
| POST | `/api/users/login` | ❌ | Login & get token |

### 👤 User Management (Require token)

| Method | Endpoint | Auth | Purpose |
|--------|----------|------|---------|
| GET | `/api/users/me` | ✅ | Get current user |
| GET | `/api/users/` | ✅ | List all users |
| GET | `/api/users/{id}` | ✅ | Get user details |
| PUT | `/api/users/{id}` | ✅ | Update profile |
| DELETE | `/api/users/{id}` | ✅ Admin | Delete user |

### 📝 Blogs (Require token for create/edit)

| Method | Endpoint | Auth | Purpose |
|--------|----------|------|---------|
| POST | `/api/blogs/` | ✅ Author | Create blog |
| GET | `/api/blogs/` | ❌ | List published |
| GET | `/api/blogs/{id}` | ❌ | Read blog |
| PUT | `/api/blogs/{id}` | ✅ Auth | Edit blog |
| DELETE | `/api/blogs/{id}` | ✅ Auth | Delete blog |
| GET | `/api/blogs/author/{id}` | ❌ | Author's blogs |

### 📢 Notices (Admin only)

| Method | Endpoint | Auth | Purpose |
|--------|----------|------|---------|
| POST | `/api/notices/` | ✅ Admin | Create notice |
| GET | `/api/notices/` | ❌ | List notices |
| GET | `/api/notices/{id}` | ❌ | Get notice |
| PUT | `/api/notices/{id}` | ✅ Admin | Edit notice |
| DELETE | `/api/notices/{id}` | ✅ Admin | Delete notice |

---

## 🔄 Complete User Flow

### Registration & Login Flow
```
User visits app
    ↓
Clicks "Register"
    ↓
Fills: username, email, password, full_name, role
    ↓
POST /api/users/register
    ↓
Database creates user & hashes password
    ↓
Redirected to login page
    ↓
Enters credentials
    ↓
POST /api/users/login
    ↓
Backend validates & returns JWT token
    ↓
Token saved to localStorage
    ↓
User state updated in React
    ↓
Redirected to home page ✅
```

### Blog Creation Flow (Author)
```
Author logs in ✅
    ↓
Clicks "Write Blog"
    ↓
Fills: title, description, content
    ↓
Clicks "Publish"
    ↓
POST /api/blogs/ (with JWT token)
    ↓
Backend creates blog in database
    ↓
Returns blog details
    ↓
User redirected to home
    ↓
Blog appears on homepage ✅
```

### Blog Management Flow (Admin)
```
Admin logs in ✅
    ↓
Goes to Admin Dashboard
    ↓
Views all blogs in table
    ↓
Finds problematic blog
    ↓
Clicks Delete
    ↓
DELETE /api/blogs/{id} (with admin token)
    ↓
Blog removed from database
    ↓
Table updates & blog gone from homepage ✅
```

---

## 🔐 Authentication Details

### JWT Token Structure
```
Header: {
  "alg": "HS256",
  "typ": "JWT"
}

Payload: {
  "sub": "1",              // user ID
  "exp": 1234567890,       // expiration time
  "iat": 1234567800        // issued at
}

Signature: HMACSHA256(header + payload, SECRET_KEY)
```

### Token Usage
```javascript
// Send with every request
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...

// Stored in localStorage
localStorage.setItem('token', token);

// Retrieved on app load
const token = localStorage.getItem('token');
```

### Password Security
```
Input: "mypassword123"
    ↓
Bcrypt hash (cost=12)
    ↓
Stored: $2b$12$R9h7cIPz0gi.URNN3kh2OPST9EysZp$...
    ↓
Verification: bcrypt.verify(input, stored) → true/false
```

---

## 💾 Data Flow Examples

### Creating a Blog

**Frontend:**
```javascript
{
  title: "My Blog",
  description: "About me",
  content: "Lorem ipsum..."
}
    ↓
POST with Authorization header
    ↓
Response: Blog object with ID
```

**Backend:**
```python
1. Verify JWT token
2. Get user ID from token
3. Validate blog data with Pydantic
4. Create Blog model instance
5. Set author_id to current user
6. Save to database
7. Return blog object
```

**Database:**
```sql
INSERT INTO blogs (title, content, description, author_id, is_published, created_at)
VALUES ('My Blog', 'Lorem ipsum...', 'About me', 1, true, NOW());
```

---

## 🎨 Frontend Component Hierarchy

```
App.js
├── Header.js (Navigation)
├── Routes
│   ├── Home.js
│   │   └── BlogCard.js (multiple)
│   ├── Login.js
│   ├── Register.js
│   ├── BlogDetail.js
│   ├── CreateBlog.js
│   └── Admin.js
└── AuthContext (Global state)
```

---

## 🛠️ Development Workflow

### Adding a New Feature

1. **Backend** - Create model, schema, route
   ```python
   # models/new_model.py
   # schemas/new_schema.py
   # routes/new_route.py
   ```

2. **Database** - Models auto-migrate with SQLAlchemy

3. **Frontend** - Add service, component, page
   ```javascript
   // services/api.js (add endpoints)
   // components/NewComponent.js
   // pages/NewPage.js
   ```

4. **Routes** - Update App.js routing

5. **Styles** - Add CSS file

---

## 🚀 Deployment Checklist

- [ ] Change SECRET_KEY in backend/.env
- [ ] Use PostgreSQL instead of SQLite
- [ ] Enable HTTPS
- [ ] Set up proper CORS
- [ ] Add rate limiting
- [ ] Set up logging
- [ ] Deploy backend (Heroku/AWS/DigitalOcean)
- [ ] Deploy frontend (Vercel/Netlify)
- [ ] Set up CI/CD pipeline
- [ ] Configure monitoring

---

## 📈 Possible Extensions

```
🌟 High Priority
├── Comments on blogs
├── Like/Unlike blogs
├── Search functionality
└── Blog categories/tags

✨ Medium Priority
├── User profiles
├── Follow users
├── Email notifications
└── Export blogs

🎯 Low Priority
├── Blog analytics
├── Social sharing
├── Dark mode
└── Multiple languages
```

---

## 🧪 Testing

### Manual Testing Checklist
- [ ] User can register
- [ ] User can login
- [ ] Author can create blog
- [ ] Blog appears on homepage
- [ ] Readers can view blog
- [ ] Admin can delete blog
- [ ] Admin can create notice
- [ ] Logout works
- [ ] Token refresh works
- [ ] CORS works correctly

### API Testing with cURL
```bash
# Register
curl -X POST http://localhost:8000/api/users/register \
  -H "Content-Type: application/json" \
  -d '{"username":"test","email":"test@test.com","full_name":"Test","password":"test123","role":"author"}'

# Login
curl -X POST http://localhost:8000/api/users/login \
  -H "Content-Type: application/json" \
  -d '{"username":"test","password":"test123"}'

# Create blog (use token from login)
curl -X POST http://localhost:8000/api/blogs/ \
  -H "Authorization: Bearer TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"title":"Test","description":"Test desc","content":"Test content"}'
```

---

## 📚 File Reference

| File | Purpose |
|------|---------|
| `main.py` | App entry point |
| `models/user.py` | User database model |
| `models/blog.py` | Blog database model |
| `models/notice.py` | Notice database model |
| `routes/users.py` | User API endpoints |
| `routes/blogs.py` | Blog API endpoints |
| `routes/notices.py` | Notice API endpoints |
| `auth.py` | JWT & password logic |
| `services/api.js` | Frontend API client |
| `context/AuthContext.js` | Authentication state |
| `pages/*.js` | React pages |
| `components/*.js` | React components |

---

## 🎓 Learning Resources

- **FastAPI**: https://fastapi.tiangolo.com
- **SQLAlchemy**: https://www.sqlalchemy.org
- **React**: https://react.dev
- **JWT**: https://jwt.io
- **REST APIs**: https://restfulapi.net

---

## 🤝 Support & Contributions

Feel free to:
- ⭐ Star the project
- 🐛 Report bugs
- 💡 Suggest features
- 📝 Submit pull requests
- 🎓 Learn from code

---

## 📄 License

MIT License - Free to use for personal & commercial projects

---

## ✨ Happy Blogging!

This project is ready for:
- ✅ Learning full-stack development
- ✅ Portfolio projects
- ✅ Production deployment
- ✅ Further customization

Start blogging now! 📝🚀
