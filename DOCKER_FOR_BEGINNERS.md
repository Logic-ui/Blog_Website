# 🎯 Docker - Getting Started (For Beginners)

## What is Docker? 🐳

**Simple explanation:** Docker packages your entire application (code + dependencies) in a box. When you run it anywhere, it works the same way.

**Benefits:**
- No more "works on my machine but not on yours" 😅
- Everyone runs identical environments
- Easy to deploy to servers
- Includes debuggers for testing

---

## Install Docker (Choose Your OS)

### 🍎 Mac Users
1. Go to: https://www.docker.com/products/docker-desktop
2. Click "Download for Mac"
3. Follow installation steps
4. Done! ✅

### 🪟 Windows Users
1. Go to: https://www.docker.com/products/docker-desktop
2. Click "Download for Windows"
3. Follow installation steps (restart required)
4. Done! ✅

### 🐧 Linux Users
```bash
# Copy-paste this entire block:
curl -fsSL https://get.docker.com -o get-docker.sh
chmod +x get-docker.sh
./get-docker.sh
rm get-docker.sh
```

### Verify Installation
```bash
docker --version
docker-compose --version
```

Should show version numbers. ✅

---

## Run Your Project (3 Simple Steps)

### Step 1: Open Terminal/Command Prompt

**Mac/Linux:**
```bash
# Navigate to project folder
cd /home/usman/Documents/Blog_Website
```

**Windows:**
```bash
# Or use Command Prompt
cd C:\Users\YourName\Documents\Blog_Website
```

### Step 2: Start Docker

**EASIEST WAY:**
```bash
docker-compose -f docker-compose.dev.yml up --build
```

This will:
- Download required images (first time only, may take 2-3 minutes)
- Start all services
- Keep running in your terminal

**Alternative (if Make is installed):**
```bash
make docker-dev
```

### Step 3: Wait for Services to Start

Watch for messages like:
```
blog-backend   | Uvicorn running on http://0.0.0.0:8000
blog-frontend  | Compiled successfully!
```

**That's it! Services are running! 🎉**

---

## Open Your App

### Frontend (React)
```
http://localhost:3000
```

### Backend API Docs
```
http://localhost:8000/docs
```

### Running Services
View everything in a new terminal:
```bash
docker-compose ps
```

---

## 🐛 Debugging - The Cool Part!

### Debug Python Code (Backend)

1. Open `backend/app/main.py` in VS Code
2. Click left of line number to add red dot (breakpoint)
3. Press `F5` in VS Code
4. Select `Python: Remote Attach (Docker)`

**Now:**
- Code stops at your breakpoint
- See variable values on left
- Use buttons to step through code

### Debug React Code (Frontend)

1. Open `frontend/src/App.js` in VS Code
2. Click left of line number to add red dot
3. Go to http://localhost:3000
4. Reload page (F5)

**Now:**
- Code stops at your breakpoint
- Use browser DevTools to inspect

---

## Common Tasks

### View Logs
```bash
# All services
docker-compose logs -f

# Just backend
docker-compose logs -f backend

# Just frontend
docker-compose logs -f frontend
```

### Stop Everything
```bash
# Press Ctrl+C in the running terminal
# Or in another terminal:
docker-compose down
```

### Install Python Package
```bash
docker-compose exec backend pip install package-name
```

### Install JavaScript Package
```bash
docker-compose exec frontend npm install package-name
```

### Access Database
```bash
docker-compose exec db psql -U bloguser -d blog_db
```

---

## 🆘 When Things Go Wrong

### Error: Port 3000 Already in Use
```bash
# Stop everything
docker-compose down

# Try again
docker-compose -f docker-compose.dev.yml up --build
```

### Error: Docker Not Starting
```bash
# Restart Docker by:
# 1. Close Docker Desktop completely
# 2. Reopen it
# 3. Try again
```

### Debugger Won't Connect
```bash
# Stop and restart backend
docker-compose restart backend

# Check logs
docker-compose logs backend
```

### Disk Space Full
```bash
# Clean everything (careful!)
docker-compose down -v
docker system prune -a
```

---

## 📁 File Organization

You don't need to understand every file, but here's what's important:

```
Blog_Website/
├── backend/              ← Python code
│   └── Dockerfile        ← How to build Python image
├── frontend/             ← React code
│   └── Dockerfile        ← How to build React image
├── docker-compose.yml    ← How to run everything
├── DOCKER_GUIDE.md       ← Full documentation
└── ...other files
```

---

## 🎬 Typical Workflow

1. **Morning: Start Development**
   ```bash
   docker-compose -f docker-compose.dev.yml up --build
   ```

2. **Edit Your Code**
   - Changes to `backend/` or `frontend/` files
   - Automatically reload ✅

3. **Debug Issues**
   - Press F5 in VS Code
   - Set breakpoints
   - Step through code

4. **End of Day: Stop Everything**
   ```bash
   docker-compose down
   ```

---

## 💡 Pro Tips

### Tip 1: Use Make Commands (Faster)
```bash
make docker-dev    # Instead of long command
make docker-down   # Stop everything
make docker-logs   # View logs
```

### Tip 2: Keep Terminal Window Open
- Docker output shows in terminal while services run
- You'll see errors immediately

### Tip 3: Use VS Code
- Perfect debugger integration
- See breakpoints visually
- Inspect variables easily

### Tip 4: Check Status
```bash
docker-compose ps
```

Should show 3 services: `db`, `backend`, `frontend`

---

## 🚀 What Services Are Running?

| Service | What It Does | Runs On |
|---------|-------------|---------|
| **Database** | Stores user data | Port 5432 |
| **Backend** | Python API server | Port 8000 |
| **Frontend** | React web app | Port 3000 |

All connected automatically! ✅

---

## 🎓 Learning Resources

### Documentation Files (Read in This Order)
1. **This file** (DOCKER_FOR_BEGINNERS.md) - ✅ You are here
2. [DOCKER_QUICK_REF.md](DOCKER_QUICK_REF.md) - Cheat sheet
3. [DOCKER_GUIDE.md](DOCKER_GUIDE.md) - Complete reference
4. [DOCKER_ARCHITECTURE.md](DOCKER_ARCHITECTURE.md) - How it works

### Testing Your Setup
Run these to verify everything works:

```bash
# 1. Check Docker
docker --version
docker-compose --version

# 2. Start services
docker-compose -f docker-compose.dev.yml up --build

# 3. In another terminal:
# Check services running
docker-compose ps

# 4. Test frontend
curl http://localhost:3000

# 5. Test backend
curl http://localhost:8000/docs

# 6. View backend logs
docker-compose logs backend

# 7. Stop everything
docker-compose down
```

---

## ✅ Checklist: You're Ready!

- [ ] Docker installed
- [ ] Terminal open in project folder
- [ ] Ran `docker-compose -f docker-compose.dev.yml up --build`
- [ ] Saw "Uvicorn running" and "Compiled successfully"
- [ ] Opened http://localhost:3000 in browser
- [ ] Opened http://localhost:8000/docs in browser
- [ ] Set a breakpoint and tried debugging
- [ ] Ran `docker-compose logs -f` to see logs

**If all checked:** Congratulations! You're a Docker expert now! 🎉

---

## 🎯 Next Steps

1. **Work On Features**
   - Edit code while Docker runs
   - See changes instantly

2. **Use Debugger**
   - Set breakpoints
   - Step through code
   - Inspect variables

3. **Read Full Docs**
   - When you need more details
   - Check [DOCKER_GUIDE.md](DOCKER_GUIDE.md)

4. **Deploy to Cloud**
   - When project is ready
   - Check [DEPLOYMENT_GUIDE.md](../DEPLOYMENT_GUIDE.md)

---

## 🔗 Quick Links

| What You Need | Link |
|---------------|------|
| Docker | https://docker.com |
| Docker Desktop | https://www.docker.com/products/docker-desktop |
| VS Code | https://code.visualstudio.com |
| Quick Reference | [DOCKER_QUICK_REF.md](DOCKER_QUICK_REF.md) |
| Full Guide | [DOCKER_GUIDE.md](DOCKER_GUIDE.md) |
| Architecture | [DOCKER_ARCHITECTURE.md](DOCKER_ARCHITECTURE.md) |

---

## 💬 Common Questions

**Q: Do I need to restart services to see code changes?**
A: No! Hot reload works automatically. Code changes appear instantly.

**Q: Can I edit code normally?**
A: Yes! Edit files in VS Code as usual. Services auto-reload.

**Q: What if I restart my computer?**
A: Stop Docker first (`docker-compose down`), then restart and run `docker-compose -f docker-compose.dev.yml up --build` again.

**Q: Is this only for development?**
A: No! You can also deploy to servers using `docker-compose.prod.yml`.

**Q: Can I work offline?**
A: Yes! After first run, everything works offline.

---

## 🎉 You're All Set!

Run this now:
```bash
docker-compose -f docker-compose.dev.yml up --build
```

Then open:
- Frontend: http://localhost:3000
- API Docs: http://localhost:8000/docs
- Press F5 in VS Code to debug!

**Happy coding!** 🚀
