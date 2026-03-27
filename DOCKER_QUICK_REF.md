# 🐳 Docker Quick Reference Card

## 🚀 Start Development

### Linux/Mac
```bash
# With debuggers enabled
docker-compose -f docker-compose.dev.yml up --build

# Or use setup script
chmod +x docker-setup.sh
./docker-setup.sh
```

### Windows
```batch
docker-compose -f docker-compose.dev.yml up --build

REM Or use setup script
docker-setup.bat
```

### With Make (if installed)
```bash
make docker-dev      # Development with debuggers
make docker-up       # Normal mode
make docker-prod     # Production mode
```

---

## 📍 Service URLs

After starting, access:

| Service | URL |
|---------|-----|
| **Frontend** | http://localhost:3000 |
| **Backend API** | http://localhost:8000 |
| **API Docs (Swagger)** | http://localhost:8000/docs |
| **Python Debugger** | localhost:5678 |
| **Node Debugger** | localhost:9229 |
| **PostgreSQL** | localhost:5432 |

---

## 🐛 Debugging

### VS Code Python Debugging
1. Start dev mode: `docker-compose -f docker-compose.dev.yml up`
2. Press `F5` in VS Code
3. Select "Python: Remote Attach (Docker)"
4. Set breakpoints in backend code
5. Make API requests to hit breakpoints

### VS Code React Debugging
1. Keep backend running
2. Press `F5` in VS Code
3. Select "Chrome: Attach (React Frontend)"
4. Open http://localhost:3000
5. Set breakpoints in React code
6. Reload browser (F5)

### Browser DevTools
1. Open http://localhost:3000
2. Press `F12` to open DevTools
3. Go to "Sources" tab
4. Set breakpoints directly
5. Reload page

---

## 📝 Common Commands

```bash
# View logs
docker-compose logs -f

# View backend logs only
docker-compose logs -f backend

# Stop all containers
docker-compose down

# Stop and remove data
docker-compose down -v

# Access backend shell
docker-compose exec backend bash

# Install Python package
docker-compose exec backend pip install package-name

# Run backend tests
docker-compose exec backend pytest

# Access database
docker-compose exec db psql -U bloguser -d blog_db
```

---

## 🔧 Configuration

### Environment Variables

Edit `.env.docker`:
```env
DEBUG_MODE=1                    # Enable debuggers
REACT_APP_API_URL=http://localhost:8000
DATABASE_URL=postgresql://user:pass@db:5432/blog_db
SECRET_KEY=your-secret-key
```

Run with environment file:
```bash
docker-compose --env-file .env.docker up
```

---

## 🐛 Debugging Python (FastAPI)

### In VS Code

**Step 1: Create `.vscode/launch.json` (already done)**
- Located at `.vscode/launch.json`

**Step 2: Start Docker**
```bash
docker-compose -f docker-compose.dev.yml up
```

**Step 3: Start Debugger**
- Press `F5` or Run → Start Debugging
- Select "Python: Remote Attach (Docker)"

**Step 4: Set Breakpoints**
- Click on line number in `backend/` files
- Red dot appears
- Make API request to hit breakpoint

**Step 5: Debug**
- Step over: `F10`
- Step into: `F11`
- Continue: `F5`
- View variables: On left panel

---

## 🐛 Debugging React (Frontend)

### In VS Code

**Step 1: Start Docker**
```bash
docker-compose -f docker-compose.dev.yml up
```

**Step 2: Start Debugger**
- Press `F5` or Run → Start Debugging
- Select "Chrome: Attach (React Frontend)"

**Step 3: Open Browser**
- Navigate to http://localhost:3000

**Step 4: Set Breakpoints**
- Click line number in `frontend/src/` files
- Red dot appears
- Reload browser to hit breakpoint

---

## 🏗️ File Structure

```
Blog_Website/
├── backend/
│   ├── Dockerfile
│   ├── requirements.txt
│   ├── app/
│   └── main.py
├── frontend/
│   ├── Dockerfile
│   ├── package.json
│   └── src/
├── docker-compose.yml          # Default (flexible)
├── docker-compose.dev.yml      # Development (debuggers on)
├── docker-compose.prod.yml     # Production (optimized)
├── .env.docker                 # Environment variables
├── DOCKER_GUIDE.md             # Full documentation
└── Makefile                    # Convenient commands
```

---

## 🆘 Troubleshooting

### Port Already in Use
```bash
# Find process using port
lsof -i :3000
# Kill process
kill -9 <PID>
```

### Debugger Not Connecting
```bash
# Check logs
docker-compose logs backend
docker-compose logs frontend

# Restart service
docker-compose restart backend
```

### Build Fails
```bash
# Rebuild without cache
docker-compose build --no-cache
```

### Database Connection Error
```bash
# Restart database
docker-compose restart db
# Or reset everything
docker-compose down -v
```

### Out of Disk Space
```bash
# Clean up Docker
docker system prune -a
docker volume prune
```

---

## 🔄 Workflow

1. **Start Development**
   ```bash
   make docker-dev
   # or
   docker-compose -f docker-compose.dev.yml up
   ```

2. **Edit Code**
   - Edit files in `backend/` or `frontend/`
   - Hot reload works automatically ✅

3. **Debug Issues**
   - Set breakpoints
   - Press F5 to attach debugger
   - Reload app/browser

4. **View Logs**
   ```bash
   docker-compose logs -f backend
   ```

5. **Stop When Done**
   ```bash
   docker-compose down
   ```

---

## 📊 Compose Files

| File | Use | Debuggers | Auto-reload |
|------|-----|-----------|-------------|
| `docker-compose.yml` | Default (flexible) | Via env var | Yes |
| `docker-compose.dev.yml` | Development | ✅ Always | ✅ Yes |
| `docker-compose.prod.yml` | Production | ❌ No | ❌ No |

---

## 🎯 Next Steps

1. ✅ Install Docker Desktop
2. ✅ Run: `make docker-dev` (or `docker-compose -f docker-compose.dev.yml up`)
3. ✅ Open http://localhost:3000
4. ✅ Press F5 in VS Code to start debugging
5. ✅ Set breakpoints and enjoy! 🚀

---

## 📚 Full Documentation

See [DOCKER_GUIDE.md](DOCKER_GUIDE.md) for comprehensive guide including:
- Detailed setup instructions
- Debugger configuration
- Database management
- Production deployment
- Performance optimization
