@echo off
REM 🚀 Blog Website Deployment Script (Windows)

echo ======================================
echo    Blog Website Deployment Helper
echo ======================================
echo.

echo FREE DEPLOYMENT OPTIONS:
echo.
echo 1) Deploy Frontend (React) to Vercel
echo 2) Deploy Frontend to Netlify
echo 3) Deploy Backend (FastAPI) to Render
echo 4) Deploy Backend to Railway
echo 5) Deploy Backend to PythonAnywhere
echo 6) Deploy to Replit (Full Stack)
echo 7) Setup PostgreSQL Database (Neon)
echo 8) View Full Deployment Guide
echo.

set /p choice="Choose option (1-8): "

if "%choice%"=="1" (
    echo.
    echo Vercel Frontend Deployment
    echo.
    echo Prerequisites:
    echo - GitHub account with your repo pushed
    echo.
    echo Steps:
    echo 1. Visit: https://vercel.com
    echo 2. Click 'New Project'
    echo 3. Import your Blog_Website repository
    echo 4. Set Root Directory: 'frontend'
    echo 5. Add Environment Variable:
    echo    - REACT_APP_API_URL = your-backend-url
    echo 6. Click Deploy
    echo.
    echo Your frontend will be live at: https://yourproject.vercel.app
) else if "%choice%"=="2" (
    echo.
    echo Netlify Frontend Deployment
    echo Prerequisites: GitHub account
    echo.
    echo Steps:
    echo 1. Visit: https://netlify.com
    echo 2. Create New site from Git
    echo 3. Configure base directory: frontend
    echo 4. Build command: npm run build
    echo 5. Publish directory: build
    echo.
) else if "%choice%"=="3" (
    echo.
    echo Render Backend Deployment
    echo.
    echo Prerequisites: Render account
    echo.
    echo Steps:
    echo 1. Visit: https://render.com
    echo 2. Create Web Service
    echo 3. Root Directory: backend
    echo 4. Build: pip install -r requirements.txt
    echo 5. Start: uvicorn app.main:app --host 0.0.0.0 --port %%PORT%%
    echo.
) else if "%choice%"=="8" (
    type DEPLOYMENT_GUIDE.md
) else (
    echo Invalid option!
    exit /b 1
)

echo.
echo Setup complete!
pause
