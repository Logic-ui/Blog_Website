# 🚀 Free Deployment Guide

## **Frontend Deployment Options**

### **Option 1: Vercel (Recommended - Easiest)**
✅ Best for React projects | Zero configuration | Automatic deployments

**Steps:**
1. Push your project to GitHub
2. Go to [vercel.com](https://vercel.com)
3. Click "New Project" → Import your GitHub repo
4. Select `frontend` folder as root directory
5. Click Deploy

**Environment Variables:**
- Set `REACT_APP_API_URL` to your backend URL

---

### **Option 2: Netlify**
✅ Easy setup | Good free tier | 100GB bandwidth/month

**Steps:**
1. Push project to GitHub
2. Go to [netlify.com](https://netlify.com)
3. Click "New site from Git" → Select repo
4. Set build command: `npm run build`
5. Set publish directory: `build`
6. Add environment variables: `REACT_APP_API_URL`
7. Deploy

---

### **Option 3: GitHub Pages**
✅ Free | Simple | Limited to static hosting

**Steps:**
1. Build the project: `npm run build`
2. Add to `package.json`:
   ```json
   "homepage": "https://yourusername.github.io/Blog_Website"
   ```
3. Generate build and set up GitHub Actions for auto-deployment

---

## **Backend Deployment Options**

### **Option 1: Render (Recommended - Free Tier)**
✅ 750 free hours/month | Python support | Easy deployment

**Steps:**
1. Push backend to GitHub
2. Go to [render.com](https://render.com)
3. Click "New +" → "Web Service"
4. Connect GitHub repo
5. Configure:
   - **Name**: `blog-api`
   - **Environment**: `Python 3`
   - **Build Command**: `pip install -r requirements.txt`
   - **Start Command**: `uvicorn app.main:app --host 0.0.0.0 --port $PORT`
   - **Root Directory**: `backend`
6. Add Environment Variables:
   - `DATABASE_URL` (if using PostgreSQL)
   - Any other `.env` variables
7. Deploy

**Note**: Free tier sleeps after 15 minutes of inactivity

---

### **Option 2: Railway**
✅ $5 free credit/month | Python support | Good performance

**Steps:**
1. Go to [railway.app](https://railway.app)
2. Click "New Project"
3. Select "Deploy from GitHub"
4. Connect your repository
5. Configure root directory to `backend`
6. Add environment variables
7. Railway auto-detects Python and deploys
8. Get public URL from dashboard

---

### **Option 3: PythonAnywhere**
✅ Free tier available | Python-specific | Always on

**Steps:**
1. Go to [pythonanywhere.com](https://pythonanywhere.com)
2. Create free account
3. Upload your backend code via Git or zip
4. Create new Web app with FastAPI configuration
5. Configure WSGI file to point to your FastAPI app
6. Set up virtual environment and install requirements
7. Reload web app
8. Use `yourusername.pythonanywhere.com` as your API URL

---

### **Option 4: Replit**
✅ Free | Simple | Good for learning

**Steps:**
1. Go to [replit.com](https://replit.com)
2. Click "Create Repl"
3. Import from GitHub
4. Select Python as language
5. Create `.replit` file:
   ```
   run = "cd backend && python main.py"
   ```
6. Click Run
7. Get public URL from right panel

---

## **Database Deployment**

### **SQLite (Current)**
- Currently using SQLite → Works as-is
- Data stored in `blog.db` file
- **Warning**: Data loss if instance restarts

### **Upgrade to PostgreSQL (Free)**

**Option: Render PostgreSQL**
1. Go to Render dashboard
2. Create new PostgreSQL database (free tier)
3. Get connection string
4. Update your backend:
   ```python
   DATABASE_URL = "postgresql://user:pass@host/db"
   ```

**Option: Neon DB**
- Free PostgreSQL hosting
- Go to [neon.tech](https://neon.tech)
- Create account and database
- Use connection string in your app

---

## **Step-by-Step Deployment (Recommended Setup)**

### **Complete Setup: Vercel + Render + Neon PostgreSQL**

#### **1. Backend Database - Neon PostgreSQL**
```bash
# Create account at neon.tech
# Create new project
# Copy connection string
```

#### **2. Backend - Render**
```bash
# Push to GitHub
# Create Web Service on Render
# Add DATABASE_URL from Neon
# Deploy
```

#### **3. Frontend - Vercel**
```bash
# Push to GitHub
# Import on Vercel
# Set REACT_APP_API_URL to Render API URL
# Deploy
```

---

## **Update Backend for Production**

Edit `backend/main.py`:

```python
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

# Add CORS for frontend URL
origins = [
    "https://your-vercel-frontend.vercel.app",  # Vercel frontend
    "https://your-netlify-frontend.netlify.app",  # Or Netlify
    "http://localhost:3000",  # Local development
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
```

---

## **Update Frontend for Production**

Create `.env.production`:
```
REACT_APP_API_URL=https://your-render-backend.onrender.com
```

Update `frontend/src/services/api.js`:
```javascript
const API_URL = process.env.REACT_APP_API_URL || 'http://localhost:8000';

export default axios.create({
  baseURL: API_URL,
});
```

---

## **Cost Breakdown (All Free)**

| Service | Cost | Monthly Free Allocation |
|---------|------|------------------------|
| Vercel Frontend | ✅ Free | Unlimited builds, deployments |
| Render Backend | ✅ Free | 750 hours (15hrs/day × 50 days) |
| Neon PostgreSQL | ✅ Free | 3GB storage, 10GB bandwidth |
| **Total** | **✅ $0** | **Everything free** |

---

## **Troubleshooting**

### **API Connection Issues**
- Check CORS configuration
- Verify `REACT_APP_API_URL` is set correctly
- Test backend with Postman/Insomnia at deployed URL

### **Backend Keeps Sleeping (Render)**
- Upgrade to paid tier, or
- Use Railway/PythonAnywhere instead

### **Database Not Persisting (SQLite)**
- Switch to PostgreSQL (Neon recommended)

---

## **Production Checklist**

- [ ] Database URL configured in backend
- [ ] CORS origins set correctly
- [ ] Environment variables added to deployment platform
- [ ] Frontend can reach backend API
- [ ] User authentication working
- [ ] Blog CRUD operations tested
- [ ] Admin functionality verified

---

## **Quick Links**

- Vercel: https://vercel.com
- Netlify: https://netlify.com
- Render: https://render.com
- Railway: https://railway.app
- Neon DB: https://neon.tech
- PythonAnywhere: https://pythonanywhere.com
- Replit: https://replit.com
