# 🐳 Docker Setup Guide with Debugger

## Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop) installed
- [Docker Compose](https://docs.docker.com/compose/install/) (included with Docker Desktop)

---

## Quick Start

### 1️⃣ Development Mode (With Debuggers)

Run the entire project with Python and Node debuggers enabled:

```bash
docker-compose -f docker-compose.dev.yml up --build
```

**What starts:**
- 🗄️ PostgreSQL Database on port 5432
- ⚙️ FastAPI Backend on port 8000 (with Python debugger on 5678)
- 🎨 React Frontend on port 3000 (with Node debugger on 9229)

---

## Configuration Files

### `docker-compose.yml` - Default (Flexible)
- Use environment variables via `.env.docker`
- Can run with or without debuggers via `DEBUG_MODE` variable

```bash
# Production mode
docker-compose up

# Development mode with debuggers
DEBUG_MODE=1 docker-compose up
```

### `docker-compose.dev.yml` - Development (Always Debuggers Enabled)
- Debuggers always on
- Hot reload enabled
- Best for development

```bash
docker-compose -f docker-compose.dev.yml up
```

### `docker-compose.prod.yml` - Production (Optimized)
- No debuggers
- Optimized builds
- Environment variables from `.env` file

```bash
docker-compose -f docker-compose.prod.yml up
```

---

## Debugging

### 🐍 Python Debugger (Backend)

**VS Code Setup:**

1. Install [Python Extension](https://marketplace.visualstudio.com/items?itemName=ms-python.python)
2. Create `.vscode/launch.json`:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Python: Remote Attach (Docker)",
      "type": "python",
      "request": "attach",
      "port": 5678,
      "host": "localhost",
      "pathMapping": {
        "/app": "${workspaceFolder}/backend"
      },
      "justMyCode": false
    }
  ]
}
```

3. Start Docker: `docker-compose -f docker-compose.dev.yml up`
4. In VS Code: Press `F5` or click "Run and Debug"
5. Select "Python: Remote Attach (Docker)"
6. Set breakpoints in your Python code

**PyCharm Setup:**

1. Go to: Run → Edit Configurations
2. Click "+" → Python → Remote Debug
3. Set:
   - Host: `localhost`
   - Port: `5678`
4. Click Run → Debug
5. Start Docker and set breakpoints

---

### ⚛️ React/Node Debugger (Frontend)

**VS Code Setup:**

1. Install [Debugger for Chrome](https://marketplace.visualstudio.com/items?itemName=msjsdiag.debugger-chrome)
2. Create/update `.vscode/launch.json`:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "chrome",
      "request": "attach",
      "name": "Attach Chrome",
      "address": "localhost",
      "port": 9229,
      "pathMapping": {
        "/app": "${workspaceFolder}/frontend",
        "/app/src": "${workspaceFolder}/frontend/src"
      }
    }
  ]
}
```

3. Start Docker: `docker-compose -f docker-compose.dev.yml up`
4. Open browser to `http://localhost:3000`
5. In VS Code: Press `F5` to attach debugger
6. Set breakpoints and reload page

**Chrome DevTools:**

1. Open Chrome DevTools (F12)
2. Go to Sources tab
3. Set breakpoints directly in the browser
4. Reload page (F5)

---

## Available Commands

### Build Images

```bash
# Build everything
docker-compose build

# Build specific service
docker-compose build backend
docker-compose build frontend
```

### Start/Stop

```bash
# Start in background
docker-compose -f docker-compose.dev.yml up -d

# Stop all containers
docker-compose -f docker-compose.dev.yml down

# Stop and remove volumes (careful - deletes data!)
docker-compose -f docker-compose.dev.yml down -v

# View logs
docker-compose -f docker-compose.dev.yml logs

# Follow backend logs
docker-compose -f docker-compose.dev.yml logs -f backend

# Follow frontend logs
docker-compose -f docker-compose.dev.yml logs -f frontend
```

### Execute Commands

```bash
# Run command in backend container
docker-compose exec backend python -m pip list

# Install new Python package
docker-compose exec backend pip install new-package

# Run command in frontend container
docker-compose exec frontend npm install new-package

# Open bash in backend
docker-compose exec backend bash

# Open bash in frontend
docker-compose exec frontend sh
```

### Database Commands

```bash
# Access PostgreSQL
docker-compose exec db psql -U bloguser -d blog_db

# View tables
\dt

# Exit psql
\q

# Export database
docker-compose exec db pg_dump -U bloguser blog_db > backup.sql
```

---

## Environment Configuration

### Create `.env.docker` file:

```bash
cp .env.docker .env.docker
```

Edit `.env.docker` with your settings:

```env
# Database
DB_USER=bloguser
DB_PASSWORD=blogpass
DB_NAME=blog_db

# Backend
SECRET_KEY=your-secret-key
REACT_APP_API_URL=http://localhost:8000

# Debug mode
DEBUG_MODE=1
```

### Use environment variables:

```bash
docker-compose --env-file .env.docker up
```

---

## Troubleshooting

### Issue: Port Already in Use

```bash
# Find what's using port 3000
lsof -i :3000

# Or kill the process
kill -9 <PID>

# Change port in docker-compose.yml
# Change "3000:3000" to "3001:3000"
```

### Issue: Database Connection Error

```bash
# Restart database service
docker-compose restart db

# Check database logs
docker-compose logs db

# Reset data (WARNING - deletes everything)
docker-compose down -v
docker-compose up
```

### Issue: Debugger Not Connecting

**Python Debugger:**
```bash
# Check if port 5678 is open
docker-compose logs backend | grep debugpy

# Restart backend
docker-compose restart backend
```

**Node Debugger:**
```bash
# Check if port 9229 is open
netstat -an | grep 9229

# View frontend logs
docker-compose logs frontend
```

### Issue: Hot Reload Not Working

```bash
# Check volume mounts
docker inspect blog-backend-dev | grep -A 5 "Mounts"

# Try recreating containers
docker-compose -f docker-compose.dev.yml up --force-recreate
```

### Issue: Out of Disk Space

```bash
# Clean up Docker
docker system prune -a

# Remove unused volumes
docker volume prune
```

---

## Performance Tips

### Reduce Build Time

```bash
# Use BuildKit for faster builds
DOCKER_BUILDKIT=1 docker-compose build
```

### Monitor Resource Usage

```bash
# View container stats
docker stats

# Limit memory usage in docker-compose.yml
services:
  backend:
    deploy:
      resources:
        limits:
          memory: 512M
```

### Speed Up Development

```bash
# Run only backend (if working on backend)
docker-compose -f docker-compose.dev.yml up backend db

# Run only frontend (if working on frontend)
docker-compose -f docker-compose.dev.yml up frontend
```

---

## Production Deployment

### Build for Production

```bash
docker-compose -f docker-compose.prod.yml build
```

### Deploy to Server

```bash
# Push to Docker Hub
docker tag blog-backend your-username/blog-backend:latest
docker push your-username/blog-backend:latest

docker tag blog-frontend your-username/blog-frontend:latest
docker push your-username/blog-frontend:latest
```

### Deploy on Server

```bash
# On production server
docker-compose -f docker-compose.prod.yml pull
docker-compose -f docker-compose.prod.yml up -d
docker-compose -f docker-compose.prod.yml logs -f
```

---

## Health Checks

### Check Service Status

```bash
# View container health
docker-compose ps

# Check specific service
docker-compose exec backend curl http://localhost:8000/docs

# Check frontend
docker-compose exec frontend curl http://localhost:3000
```

### Monitor Logs

```bash
# All services
docker-compose logs --tail=100 -f

# Specific service with timestamps
docker-compose logs --timestamps -f backend
```

---

## Useful Docker Commands

```bash
# List all containers
docker ps -a

# View image layers
docker history blog-backend

# Inspect container
docker inspect blog-backend

# Copy file from container
docker cp blog-backend:/app/blog.db ./

# Copy file to container
docker cp ./file.txt blog-backend:/app/

# Remove all stopped containers
docker container prune

# Remove specific container
docker rm blog-backend
```

---

## Quick Reference

| Task | Command |
|------|---------|
| Start dev with debuggers | `docker-compose -f docker-compose.dev.yml up` |
| Start normal | `docker-compose up` |
| Start production | `docker-compose -f docker-compose.prod.yml up` |
| Stop all | `docker-compose down` |
| View logs | `docker-compose logs -f` |
| Rebuild images | `docker-compose build --no-cache` |
| Access backend bash | `docker-compose exec backend bash` |
| Install Python package | `docker-compose exec backend pip install package` |
| Install Node package | `docker-compose exec frontend npm install package` |
| Database shell | `docker-compose exec db psql -U bloguser -d blog_db` |
| Clean everything | `docker-compose down -v && docker system prune -a` |

---

## Next Steps

1. ✅ Install Docker Desktop
2. ✅ Run: `docker-compose -f docker-compose.dev.yml up --build`
3. ✅ Set up debugger in VS Code
4. ✅ Open browser to `http://localhost:3000`
5. ✅ Set breakpoints and start debugging!

Happy debugging! 🚀
