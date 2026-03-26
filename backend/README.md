# Backend API Documentation

## 🚀 Getting Started

### Installation

```bash
# Create virtual environment
python -m venv venv

# Activate virtual environment
# Windows:
venv\Scripts\activate
# macOS/Linux:
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt
```

### Running the Server

```bash
python main.py
```

Server will start at `http://localhost:8000`

### Interactive API Docs
Visit `http://localhost:8000/docs` for Swagger UI

---

## 📚 API Reference

### Authentication

All protected endpoints require a Bearer token in the Authorization header:
```
Authorization: Bearer <access_token>
```

---

### User Endpoints

#### Register
```http
POST /api/users/register
Content-Type: application/json

{
  "username": "johndoe",
  "email": "john@example.com",
  "full_name": "John Doe",
  "password": "securepassword",
  "role": "reader"  // or "author"
}
```

Response:
```json
{
  "id": 1,
  "username": "johndoe",
  "email": "john@example.com",
  "full_name": "John Doe",
  "role": "reader",
  "is_active": true,
  "created_at": "2024-01-01T00:00:00"
}
```

#### Login
```http
POST /api/users/login
Content-Type: application/json

{
  "username": "johndoe",
  "password": "securepassword"
}
```

Response:
```json
{
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "token_type": "bearer",
  "user": {
    "id": 1,
    "username": "johndoe",
    "email": "john@example.com",
    "full_name": "John Doe",
    "role": "reader",
    "is_active": true,
    "created_at": "2024-01-01T00:00:00"
  }
}
```

#### Get Current User
```http
GET /api/users/me
Authorization: Bearer <token>
```

#### List All Users
```http
GET /api/users/
```

#### Get User by ID
```http
GET /api/users/{user_id}
```

#### Update User
```http
PUT /api/users/{user_id}
Authorization: Bearer <token>
Content-Type: application/json

{
  "full_name": "John Updated",
  "email": "newemail@example.com"
}
```

#### Delete User
```http
DELETE /api/users/{user_id}
Authorization: Bearer <token>
```
(Admin only)

---

### Blog Endpoints

#### Create Blog
```http
POST /api/blogs/
Authorization: Bearer <token>
Content-Type: application/json

{
  "title": "My First Blog Post",
  "description": "This is my first blog",
  "content": "Lorem ipsum dolor sit amet..."
}
```

Response:
```json
{
  "id": 1,
  "title": "My First Blog Post",
  "content": "Lorem ipsum dolor sit amet...",
  "description": "This is my first blog",
  "author_id": 1,
  "is_published": true,
  "created_at": "2024-01-01T00:00:00",
  "updated_at": "2024-01-01T00:00:00"
}
```

#### List All Published Blogs
```http
GET /api/blogs/
```

#### Get Blog by ID
```http
GET /api/blogs/{blog_id}
```

#### Get Author's Blogs
```http
GET /api/blogs/author/{author_id}
```

#### Update Blog
```http
PUT /api/blogs/{blog_id}
Authorization: Bearer <token>
Content-Type: application/json

{
  "title": "Updated Title",
  "content": "Updated content...",
  "description": "Updated description",
  "is_published": true
}
```

#### Delete Blog
```http
DELETE /api/blogs/{blog_id}
Authorization: Bearer <token>
```
(Author or Admin only)

---

### Notice Endpoints

#### Create Notice (Admin Only)
```http
POST /api/notices/
Authorization: Bearer <admin_token>
Content-Type: application/json

{
  "title": "System Maintenance",
  "content": "Scheduled maintenance on Sunday..."
}
```

Response:
```json
{
  "id": 1,
  "title": "System Maintenance",
  "content": "Scheduled maintenance on Sunday...",
  "sender_id": 1,
  "created_at": "2024-01-01T00:00:00",
  "updated_at": "2024-01-01T00:00:00"
}
```

#### List All Notices
```http
GET /api/notices/
```

#### Get Notice by ID
```http
GET /api/notices/{notice_id}
```

#### Update Notice (Admin Only)
```http
PUT /api/notices/{notice_id}
Authorization: Bearer <admin_token>
Content-Type: application/json

{
  "title": "Updated Notice",
  "content": "Updated content..."
}
```

#### Delete Notice (Admin Only)
```http
DELETE /api/notices/{notice_id}
Authorization: Bearer <admin_token>
```

---

## 🔄 HTTP Status Codes

| Code | Meaning |
|------|---------|
| 200 | Success |
| 201 | Created |
| 400 | Bad Request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not Found |
| 500 | Server Error |

---

## 🏗️ Code Structure

### models/
- `user.py` - User model with roles
- `blog.py` - Blog post model
- `notice.py` - Admin notices model

### routes/
- `users.py` - User authentication and management
- `blogs.py` - Blog CRUD operations
- `notices.py` - Notice management

### schemas/
- `user.py` - User validation schemas
- `blog.py` - Blog validation schemas
- `notice.py` - Notice validation schemas

### database/
- `database.py` - Database configuration and session

### auth.py
- Password hashing and JWT token handling

---

## 🔒 Security Features

- **Password Hashing**: Bcrypt with salt
- **JWT Authentication**: Stateless token-based auth
- **Role-Based Access Control**: Admin, Author, Reader roles
- **CORS Support**: Configurable for different origins
- **SQL Injection Protection**: SQLAlchemy ORM

---

## 🧪 Testing

### Create test data via API:

```bash
# Register user
curl -X POST http://localhost:8000/api/users/register \
  -H "Content-Type: application/json" \
  -d '{
    "username": "testuser",
    "email": "test@example.com",
    "full_name": "Test User",
    "password": "test123",
    "role": "author"
  }'

# Login
curl -X POST http://localhost:8000/api/users/login \
  -H "Content-Type: application/json" \
  -d '{
    "username": "testuser",
    "password": "test123"
  }'

# Create blog (use token from login response)
curl -X POST http://localhost:8000/api/blogs/ \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Test Blog",
    "description": "A test blog post",
    "content": "This is test content..."
  }'
```

---

## 📝 Environment Variables

Create `.env` file in backend directory:

```
DATABASE_URL=sqlite:///./blog.db
SECRET_KEY=your-secret-key-change-in-production
```

For PostgreSQL:
```
DATABASE_URL=postgresql://username:password@localhost:5432/blog_db
SECRET_KEY=your-secret-key-change-in-production
```

---

## 📦 Dependencies

- **fastapi**: Web framework
- **uvicorn**: ASGI server
- **sqlalchemy**: ORM
- **pydantic**: Data validation
- **python-jose**: JWT handling
- **passlib**: Password utilities
- **bcrypt**: Password hashing
- **python-multipart**: Form data handling

---

## 🚀 Deployment

### Using Gunicorn

```bash
pip install gunicorn
gunicorn -w 4 -k uvicorn.workers.UvicornWorker app.main:app
```

### Using Docker

Create `Dockerfile`:
```dockerfile
FROM python:3.11
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0"]
```

Build and run:
```bash
docker build -t blog-api .
docker run -p 8000:8000 blog-api
```

---

## 📞 Need Help?

Check the inline code comments for detailed explanations!
