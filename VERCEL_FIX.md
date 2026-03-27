# 🚀 Fix Vercel 404 Error - Complete Guide

## Problem: 404 NOT_FOUND on Vercel

Your frontend is deployed but can't find the backend API.

---

## Solution: Configure Environment Variables on Vercel

### Step 1: Get Your Backend URL

First, deploy your backend (FastAPI) to one of these:

**Option A: Render (Recommended - Free)**
- Go to [render.com](https://render.com)
- Deploy backend there
- Get URL like: `https://blog-api.onrender.com`

**Option B: Railway**
- Go to [railway.app](https://railway.app)
- Deploy backend
- Get URL like: `https://your-project.railway.app`

**Option C: PythonAnywhere**
- Go to [pythonanywhere.com](https://pythonanywhere.com)
- Get URL like: `https://username.pythonanywhere.com`

### Step 2: Add Backend URL to Vercel

1. Go to [vercel.com](https://vercel.com)
2. Select your Blog_Website project
3. Go to **Settings** → **Environment Variables**
4. Add new variable:
   - **Name**: `REACT_APP_API_URL`
   - **Value**: Your backend URL (e.g., `https://blog-api.onrender.com`)
   - **Environments**: Select Production, Preview, Development
5. Click **Save**

### Step 3: Redeploy on Vercel

After adding environment variables:

1. Go to **Deployments** tab
2. Click on the latest failed deployment
3. Click **Redeploy**
4. Wait for build to complete
5. Test: Open your Vercel URL

---

## Verify It Works

### Test Frontend
```
https://your-project.vercel.app
```

### Test API Connection
1. Open browser DevTools (F12)
2. Go to Console tab
3. Should see NO errors about API

### Test Backend Connection
1. Open in browser: `https://blog-api.onrender.com/docs` (use YOUR backend URL)
2. Should see Swagger API documentation
3. Test an endpoint

---

## Common Issues & Fixes

### Issue 1: Still Getting 404

**Cause**: Vercel not using environment variable

**Fix**:
```bash
# Redeploy with cache clear
cd Blog_Website
npm run build  # Test locally first
git add -A
git commit -m "Fix: Update API URL to use env variables"
git push
# Then redeploy on Vercel
```

### Issue 2: Backend URL is Incorrect

**Fix**:
1. Go to Vercel Settings → Environment Variables
2. Edit `REACT_APP_API_URL`
3. Make sure URL is correct (no trailing slash)
4. Click **Redeploy**

### Issue 3: CORS Error (Different Issue)

**If you see**: `Access-Control-Allow-Origin` error

**Fix Backend CORS** (backend/app/main.py):
```python
from fastapi.middleware.cors import CORSMiddleware

origins = [
    "https://your-vercel-app.vercel.app",  # Your Vercel URL
    "http://localhost:3000",                 # Local
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
```

---

## Files Modified

✅ **frontend/src/services/api.js** - Now uses `REACT_APP_API_URL` env variable
✅ **frontend/.env.production** - Updated template

---

## Step-by-Step Deployment

### Complete Workflow:

**1. Deploy Backend First**
```bash
# Go to Render/Railway/PythonAnywhere
# Deploy backend
# Get URL: e.g., https://blog-api.onrender.com
```

**2. Add Environment Variable to Vercel**
```
REACT_APP_API_URL = https://blog-api.onrender.com
```

**3. Redeploy Frontend**
```bash
# Vercel automatically rebuilds
# Or manually redeploy from Vercel dashboard
```

**4. Test Everything**
- Frontend: https://your-project.vercel.app
- Backend API: https://blog-api.onrender.com/docs
- Open console and check for errors

---

## Verification Checklist

- [ ] Backend deployed (has URL like `https://blog-api.onrender.com`)
- [ ] REACT_APP_API_URL added to Vercel environment variables
- [ ] Vercel redeployed after adding env var
- [ ] Frontend loads without 404 errors
- [ ] Can see API docs at backend URL + `/docs`
- [ ] No CORS errors in browser console

---

## Example URLs

### Frontend (Vercel)
```
https://blog-website-usman.vercel.app
```

### Backend (Render)
```
https://blog-api.onrender.com
```

### Environment Variable (Vercel Settings)
```
REACT_APP_API_URL=https://blog-api.onrender.com
```

---

## Quick Command Reference

### Local Testing
```bash
# Set env var for testing
export REACT_APP_API_URL=https://blog-api.onrender.com

# Build
npm run build

# Test build
npx serve -s build
```

### Git Push & Deploy
```bash
git add -A
git commit -m "Fix: API URL configuration"
git push
# Vercel auto-deploys on push
```

---

## Troubleshooting Guide

| Error | Cause | Fix |
|-------|-------|-----|
| 404 NOT_FOUND | API URL missing/wrong | Add `REACT_APP_API_URL` to Vercel env |
| Cannot GET / | Build failed | Check build logs in Vercel |
| CORS Error | Backend CORS config | Add Vercel URL to backend CORS |
| API Timeout | Backend sleeping | Wake up backend service |
| Blank Page | Frontend not built | Clear cache & redeploy |

---

## Security Notes

⚠️ **DO NOT**:
- Put `http://localhost` in production env var
- Commit backend URL to git (if sensitive)
- Use hardcoded URLs

✅ **DO**:
- Use environment variables (we fixed this!)
- Set different URLs for dev/prod
- Keep `.env` files in `.gitignore`

---

## Next Steps

1. **Deploy Backend** (if not done)
   - Use Render/Railway/PythonAnywhere
   - Get your backend URL

2. **Update Vercel Settings**
   - Add `REACT_APP_API_URL` env variable
   - Save and redeploy

3. **Test**
   - Open your Vercel URL
   - Check browser console
   - Should be working! ✅

4. **Monitor**
   - Check Vercel deployment logs
   - Watch for errors in browser console
   - Test API endpoints

---

## Support

If still having issues:

1. Check Vercel deployment logs
   - Go to Deployment → View Logs
   - Look for build errors

2. Check browser console
   - Press F12 → Console
   - Look for 404 or CORS errors

3. Test backend directly
   - Visit backend URL + `/docs`
   - Should see Swagger UI

4. Verify environment variable
   - Go to Settings → Environment Variables
   - Confirm `REACT_APP_API_URL` is set
   - Click Redeploy

---

**Your 404 error is fixed!** 🎉

Next time Vercel deploys, it will use the correct backend URL.
