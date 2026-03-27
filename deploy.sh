#!/bin/bash

# 🚀 Blog Website Deployment Script

echo "======================================"
echo "   Blog Website Deployment Helper"
echo "======================================"
echo ""

# Color codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}📋 FREE DEPLOYMENT OPTIONS:${NC}"
echo ""
echo -e "${GREEN}1)${NC} Deploy Frontend (React) to Vercel"
echo -e "${GREEN}2)${NC} Deploy Frontend to Netlify"
echo -e "${GREEN}3)${NC} Deploy Backend (FastAPI) to Render"
echo -e "${GREEN}4)${NC} Deploy Backend to Railway"
echo -e "${GREEN}5)${NC} Deploy Backend to PythonAnywhere"
echo -e "${GREEN}6)${NC} Deploy to Replit (Full Stack)"
echo -e "${GREEN}7)${NC} Setup PostgreSQL Database (Neon)"
echo -e "${GREEN}8)${NC} View Full Deployment Guide"
echo ""

read -p "Choose option (1-8): " choice

case $choice in
  1)
    echo ""
    echo -e "${BLUE}📱 Vercel Frontend Deployment${NC}"
    echo ""
    echo "Prerequisites:"
    echo "- GitHub account with your repo pushed"
    echo ""
    echo "Steps:"
    echo "1. Visit: https://vercel.com"
    echo "2. Click 'New Project'"
    echo "3. Import your Blog_Website repository"
    echo "4. Set Root Directory: 'frontend'"
    echo "5. Add Environment Variable:"
    echo "   - REACT_APP_API_URL = https://your-backend-url.com"
    echo "6. Click Deploy"
    echo ""
    echo -e "${YELLOW}Your frontend will be live at: https://yourproject.vercel.app${NC}"
    ;;
  
  2)
    echo ""
    echo -e "${BLUE}📱 Netlify Frontend Deployment${NC}"
    echo ""
    echo "Prerequisites:"
    echo "- GitHub account with your repo pushed"
    echo ""
    echo "Steps:"
    echo "1. Visit: https://netlify.com"
    echo "2. Click 'New site from Git'"
    echo "3. Select your repository"
    echo "4. Configure:"
    echo "   - Base directory: frontend"
    echo "   - Build command: npm run build"
    echo "   - Publish directory: build"
    echo "5. Add Environment Variable:"
    echo "   - REACT_APP_API_URL = https://your-backend-url.com"
    echo "6. Click Deploy"
    echo ""
    echo -e "${YELLOW}Your frontend will be live at: https://yoursite.netlify.app${NC}"
    ;;
  
  3)
    echo ""
    echo -e "${BLUE}⚙️ Render Backend Deployment${NC}"
    echo ""
    echo "Prerequisites:"
    echo "- GitHub account with your repo pushed"
    echo "- Render account (render.com)"
    echo ""
    echo "Steps:"
    echo "1. Visit: https://render.com"
    echo "2. Click 'New +' → 'Web Service'"
    echo "3. Connect your GitHub repository"
    echo "4. Configure:"
    echo "   - Name: blog-api"
    echo "   - Environment: Python 3"
    echo "   - Build Command: pip install -r requirements.txt"
    echo "   - Start Command: uvicorn app.main:app --host 0.0.0.0 --port \$PORT"
    echo "   - Root Directory: backend"
    echo "5. Add Environment Variables from .env.example"
    echo "6. Click Deploy"
    echo ""
    echo -e "${YELLOW}Your backend will be live at: https://blog-api.onrender.com${NC}"
    echo -e "${YELLOW}Note: Free tier sleeps after 15 mins of inactivity${NC}"
    ;;
  
  4)
    echo ""
    echo -e "${BLUE}⚙️ Railway Backend Deployment${NC}"
    echo ""
    echo "Prerequisites:"
    echo "- GitHub account with your repo pushed"
    echo ""
    echo "Steps:"
    echo "1. Visit: https://railway.app"
    echo "2. Click 'New Project'"
    echo "3. Select 'Deploy from GitHub repo'"
    echo "4. Connect your repository"
    echo "5. Set Root Directory: backend"
    echo "6. Add environment variables"
    echo "7. Railway auto-detects Python and deploys"
    echo "8. Get your public URL from the dashboard"
    echo ""
    echo -e "${YELLOW}Free: \$5 credit per month${NC}"
    ;;
  
  5)
    echo ""
    echo -e "${BLUE}⚙️ PythonAnywhere Backend Deployment${NC}"
    echo ""
    echo "Steps:"
    echo "1. Visit: https://pythonanywhere.com"
    echo "2. Create free account"
    echo "3. Upload backend code (Git or ZIP)"
    echo "4. Create Web app with FastAPI"
    echo "5. Install dependencies: pip install -r requirements.txt"
    echo "6. Configure WSGI file for FastAPI"
    echo "7. Reload web app"
    echo ""
    echo -e "${YELLOW}Your backend: https://yourusername.pythonanywhere.com${NC}"
    echo -e "${YELLOW}Advantage: Always on (no sleeping)${NC}"
    ;;
  
  6)
    echo ""
    echo -e "${BLUE}🔄 Replit Full Stack Deployment${NC}"
    echo ""
    echo "Steps:"
    echo "1. Visit: https://replit.com"
    echo "2. Create new Repl → Import from GitHub"
    echo "3. Select Python language"
    echo "4. .replit file is already configured"
    echo "5. Click Run"
    echo ""
    echo -e "${YELLOW}Your app: https://your-repl-name.replit.dev${NC}"
    ;;
  
  7)
    echo ""
    echo -e "${BLUE}🗄️ Neon PostgreSQL Database${NC}"
    echo ""
    echo "Steps:"
    echo "1. Visit: https://neon.tech"
    echo "2. Sign up and create new project"
    echo "3. Copy PostgreSQL connection string"
    echo "4. Update backend .env:"
    echo "   DATABASE_URL=postgresql://..."
    echo "5. Redeploy backend"
    echo ""
    echo -e "${YELLOW}Free: 3GB storage + 10GB bandwidth${NC}"
    ;;
  
  8)
    echo ""
    echo -e "${BLUE}📖 Opening Deployment Guide...${NC}"
    cat ./DEPLOYMENT_GUIDE.md
    ;;
  
  *)
    echo "Invalid option!"
    exit 1
    ;;
esac

echo ""
echo -e "${GREEN}✅ Setup complete!${NC}"
echo ""
