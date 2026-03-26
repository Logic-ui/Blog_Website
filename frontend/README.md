# Frontend Documentation

## 🚀 Getting Started

### Prerequisites
- Node.js 14+
- npm or yarn
- Backend server running on `http://localhost:8000`

### Installation

```bash
npm install
```

### Run Development Server

```bash
npm start
```

Opens at `http://localhost:3000`

### Build for Production

```bash
npm run build
```

---

## 📁 Project Structure

```
frontend/
├── public/
│   └── index.html          # Main HTML file
├── src/
│   ├── components/
│   │   ├── Header.js       # Navigation header
│   │   └── BlogCard.js     # Blog card component
│   ├── pages/
│   │   ├── Home.js         # Homepage - list all blogs
│   │   ├── Login.js        # Login page
│   │   ├── Register.js     # Registration page
│   │   ├── BlogDetail.js   # Blog detail page
│   │   ├── CreateBlog.js   # Create blog page
│   │   └── Admin.js        # Admin dashboard
│   ├── services/
│   │   └── api.js          # API client
│   ├── context/
│   │   └── AuthContext.js  # Authentication state
│   ├── styles/
│   │   ├── index.css       # Global styles
│   │   ├── Header.css      # Header styles
│   │   ├── Auth.css        # Auth pages styles
│   │   ├── Home.css        # Home page styles
│   │   ├── Blog.css        # Blog detail styles
│   │   ├── CreateBlog.css  # Create blog styles
│   │   └── Admin.css       # Admin styles
│   ├── App.js              # Main App component
│   └── index.js            # React entry point
└── package.json
```

---

## 🎯 Pages Overview

### Home Page
- Displays all published blogs
- Shows blog cards with title, description, and date
- Click to read full blog

### Login Page
- Username and password fields
- Error handling
- Redirects to home on success

### Register Page
- Create new account
- Choose role: Reader or Author
- Email validation
- Redirects to login

### Blog Detail Page
- Full blog content
- Author information
- Publication date
- Edit/Delete buttons for authors and admins

### Create Blog Page
- Form to create new blog post
- Title, description, and content fields
- Available for Authors and Admins only

### Admin Dashboard
- **Notices Tab**: Create and manage announcements
- **Blogs Tab**: View all blogs and delete any
- **Users Tab**: See all registered users

---

## 🔑 Authentication Flow

### Login/Register
1. User enters credentials
2. API call to backend
3. Token saved to localStorage
4. User state updated in AuthContext
5. Redirected to home page

### Protected Routes
- Routes check if user is authenticated
- Redirect unauthenticated users to login
- Authorization header includes JWT token

### Logout
- Clears token and user from localStorage
- Updates auth context
- Redirects to home

---

## 💡 Component Usage

### Header Component
```jsx
<Header />
```
Displays navigation with:
- Logo
- Home link
- Write Blog (if author/admin)
- Admin panel (if admin)
- User info and logout (if logged in)
- Login/Register links (if not logged in)

### BlogCard Component
```jsx
<BlogCard blog={blog} />
```
Shows blog preview with:
- Title
- Description
- Publication date
- Read More link

---

## 🌐 API Integration

### Services (api.js)

#### User Services
```javascript
userService.register(userData)
userService.login(credentials)
userService.getCurrentUser()
userService.getUser(userId)
userService.listUsers()
userService.updateUser(userId, userData)
userService.deleteUser(userId)
```

#### Blog Services
```javascript
blogService.createBlog(blogData)
blogService.listBlogs()
blogService.getBlog(blogId)
blogService.getAuthorBlogs(authorId)
blogService.updateBlog(blogId, blogData)
blogService.deleteBlog(blogId)
```

#### Notice Services
```javascript
noticeService.createNotice(noticeData)
noticeService.listNotices()
noticeService.getNotice(noticeId)
noticeService.updateNotice(noticeId, noticeData)
noticeService.deleteNotice(noticeId)
```

### Axios Interceptors
- Automatically adds JWT token to requests
- Retrieves token from localStorage

---

## 🔐 Authentication Context

### Usage

```javascript
import AuthContext from '../context/AuthContext';

function MyComponent() {
  const { user, login, logout } = useContext(AuthContext);
  
  if (!user) return <div>Please login</div>;
  
  return <div>Welcome {user.username}</div>;
}
```

### AuthContext Properties
- `user` - Current user object or null
- `login(userData)` - Set user and save token
- `logout()` - Clear user and token

---

## 🎨 Styling

### Global Styles (index.css)
- Font family: Segoe UI, Roboto
- Colors: Blue (#007bff), Gray (#333), Light gray (#f5f5f5)
- Box model: Flexible grid layouts

### Responsive Design
- Mobile-friendly
- Grid layouts with auto-fill
- Flex containers for spacing

### Color Scheme
```css
Primary: #007bff (Blue)
Danger: #dc3545 (Red)
Success: #28a745 (Green)
Dark: #333 (Charcoal)
Light: #f5f5f5 (Light gray)
Border: #ddd (Light border)
```

---

## 🔄 State Management

### Local State
- Each page uses `useState` for local data

### Global State
- AuthContext for authentication
- localStorage for persistence

### API State
- Axios for API calls
- Try-catch for error handling
- Loading states for UX

---

## 🚀 User Workflows

### Workflow 1: Register and Create Blog
1. Click Register
2. Fill form and choose "Author" role
3. Redirected to login
4. Login with credentials
5. Click "Write Blog"
6. Create and publish blog
7. Blog appears on homepage

### Workflow 2: Read and Admin
1. Login as Admin
2. Go to Admin panel
3. Create notices
4. Delete problematic blogs
5. View all users

### Workflow 3: Browse as Reader
1. Visit homepage (no login needed)
2. See all blogs
3. Click to read full blog
4. Optional: Login to see author details

---

## 🛠️ Configuration

### API Base URL
Edit `src/services/api.js`:
```javascript
const API_BASE_URL = 'http://localhost:8000/api';
```

### Token Storage
Currently stored in localStorage:
```javascript
localStorage.setItem('token', response.data.access_token);
localStorage.setItem('user', JSON.stringify(response.data.user));
```

---

## 📱 Responsive Breakpoints

### Grid Layouts
- Mobile: 1 column
- Tablet: 2 columns
- Desktop: 3+ columns

### Flex Layouts
- Navigation adapts to screen size
- Buttons stack on mobile

---

## 🐛 Common Issues

### CORS Errors
- Backend should have CORS enabled
- Check frontend API URL matches backend

### Token Errors
- Clear localStorage and re-login
- Check token expiration in auth.py

### Page Not Loading
- Check backend is running
- Verify API endpoints in api.js

---

## 📦 Dependencies

```json
{
  "react": "^18.2.0",
  "react-dom": "^18.2.0",
  "react-router-dom": "^6.20.0",
  "axios": "^1.6.2",
  "react-scripts": "5.0.1"
}
```

---

## 🚀 Production Build

```bash
npm run build
```

Creates optimized build in `build/` folder

Deploy to:
- Vercel
- Netlify
- GitHub Pages
- AWS S3
- Any static hosting

---

## 🔗 Environment Setup

### Development
```bash
npm start
```

### Testing
```bash
npm test
```

### Production Build
```bash
npm run build
```

---

## 📞 Support

Check component comments and page comments for details!

Happy coding! 🚀
