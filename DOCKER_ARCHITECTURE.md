# 🐳 Docker Architecture & Debugger Setup

## System Architecture

```
┌─────────────────────────────────────────────────────────┐
│              Docker Compose Orchestration               │
└─────────────────────────────────────────────────────────┘
                            │
        ┌───────────────────┼───────────────────┬──────────────┐
        │                   │                   │              │
        ▼                   ▼                   ▼              ▼
┌──────────────┐     ┌───────────┐        ┌─────────┐  ┌──────────┐
│  PostgreSQL  │     │  Backend  │        │Frontend │  │ Networks │
│   Database   │     │  FastAPI  │        │ React   │  │ & Volumes│
│              │     │           │        │         │  │          │
│ Port: 5432   │     │ Port: 8000│        │Port:3000   └──────────┘
│ Volume: Data │     │ Port: 5678│        │Port:9229│
│              │     │(Debugger) │        │(Debug.) │
└──────────────┘     └───────────┘        └─────────┘
       │                   │                   │
       └───────────────────┼───────────────────┘
                           │
                      Shared Network
                  (blog-network-dev)
```

---

## Port Mapping

```
Host Machine          Docker Container
─────────────────────────────────────

localhost:3000  ──→  frontend:3000     (React)
localhost:8000  ──→  backend:8000      (FastAPI)
localhost:5432  ──→  db:5432           (PostgreSQL)
localhost:5678  ──→  backend:5678      (Python Debugger)
localhost:9229  ──→  frontend:9229     (Node Debugger)
```

---

## Volume Mounts (Hot Reload)

```
Host Machine                  Docker Container
──────────────────────────────────────────────

./backend/src         ──→    /app/src        (Live edits)
./frontend/src        ──→    /app/src        (Live edits)
./frontend/public     ──→    /app/public     (Assets)

postgres_data_dev     ←──    /var/lib/postgresql/data  (Persistent)
```

---

## Python Debugging Flow

```
┌─ VS Code ─────────────┐
│                       │
│  .vscode/launch.json  │
│  (Port 5678 config)   │
│                       │
└───────────┬───────────┘
            │
            │ F5 (Attach)
            │
            ▼
┌─────────────────────────┐
│  Backend Container      │
│  debugpy listening at   │
│  0.0.0.0:5678         │
│                       │
│  breakpoints triggered  │
│  ──────────────────────│
│  variables inspected   │
│  step through code     │
│                       │
└─────────────────────────┘
```

---

## React Debugging Flow

```
┌─ Chrome/VS Code ────────┐
│                         │
│ Browser DevTools        │
│ or VS Code Debugger     │
│ (Port 9229)             │
│                         │
└────────┬────────────────┘
         │
         │ Attach
         │
         ▼
┌─────────────────────────┐
│ Frontend Container      │
│ npm start               │
│ (Hot reload enabled)    │
│                         │
│ breakpoints triggered   │
│ ──────────────────────  │
│ inspect React state     │
│ debug components        │
│                         │
└─────────────────────────┘
```

---

## File Structure with Docker

```
Blog_Website/
│
├── backend/
│   ├── Dockerfile                 ← Python 3.11 image
│   ├── requirements.txt           ← debugpy, psycopg2 added
│   ├── app/
│   │   ├── main.py
│   │   ├── routes/
│   │   ├── models/
│   │   └── auth.py
│   └── main.py
│
├── frontend/
│   ├── Dockerfile                 ← Node 18 image
│   ├── package.json
│   ├── src/
│   │   ├── components/
│   │   ├── pages/
│   │   └── App.js
│   └── public/
│
├── docker-compose.yml             ← Flexible config
├── docker-compose.dev.yml         ← Dev (debuggers on)
├── docker-compose.prod.yml        ← Prod (optimized)
│
├── .env.docker                    ← Environment variables
├── .dockerignore                  ← Ignore files
│
├── .vscode/
│   ├── launch.json                ← Debugger config ✅
│   └── tasks.json                 ← Docker tasks ✅
│
├── DOCKER_GUIDE.md                ← Full documentation
├── DOCKER_QUICK_REF.md           ← Quick reference
├── DOCKER_SETUP_SUMMARY.md       ← Summary
│
├── docker-setup.sh                ← Linux/Mac setup
└── docker-setup.bat               ← Windows setup
```

---

## Debugger Connection Diagram

### Python Debugger (debugpy)

```
VS Code Remote Debugger
        │
        │ Connect to 0.0.0.0:5678
        │
        ▼
┌──────────────────────┐
│  Docker Container    │
│                      │
│  python -m debugpy   │
│  --listen 0.0.0.0... │
│  -m uvicorn ...      │
│                      │
│  ✓ Breakpoints       │
│  ✓ Step Debug        │
│  ✓ Watch Variables   │
│  ✓ Call Stack        │
│                      │
└──────────────────────┘
```

### Node Debugger

```
Chrome DevTools / VS Code
        │
        │ Chrome Protocol
        │
        ▼
┌──────────────────────┐
│  Frontend Container  │
│                      │
│  npm start           │
│  NODE_OPTIONS=       │
│  --inspect-brk=...   │
│                      │
│  ✓ Breakpoints       │
│  ✓ Console Logs      │
│  ✓ React Components  │
│  ✓ Network Requests  │
│                      │
└──────────────────────┘
```

---

## Hot Reload Mechanism

```
Edit File: backend/app/main.py
     │
     ▼
Uvicorn detects change (--reload)
     │
     ▼
Container restarts process
     │
     ▼
Debugger stays connected (port 5678)
     │
     ▼
You can continue debugging!
```

```
Edit File: frontend/src/App.js
     │
     ▼
Webpack detects change
     │
     ▼
Recompiles React code
     │
     ▼
Browser auto-reloads (if configured)
     │
     ▼
Debugger still attached!
```

---

## Compose Files Comparison

```
┌─────────────────────────────────────────────────────────┐
│ docker-compose.yml (DEFAULT - FLEXIBLE)               │
├─────────────────────────────────────────────────────────┤
│ • Uses environment variables                           │
│ • Debugger: Via DEBUG_MODE=0/1                         │
│ • Usage: docker-compose up                             │
│ • Usage: DEBUG_MODE=1 docker-compose up                │
│ • Recommended for: Learning & experimentation          │
└─────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────┐
│ docker-compose.dev.yml (DEVELOPMENT)                  │
├─────────────────────────────────────────────────────────┤
│ ✓ Debuggers: ALWAYS enabled                            │
│ ✓ Hot reload: ALWAYS on                                │
│ ✓ Volumes: Full source mount                           │
│ ✓ Database: PostgreSQL                                 │
│ • Usage: docker-compose -f docker-compose.dev.yml up   │
│ • Recommended for: Active development & debugging      │
└─────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────┐
│ docker-compose.prod.yml (PRODUCTION)                  │
├─────────────────────────────────────────────────────────┤
│ ✗ Debuggers: DISABLED                                   │
│ ✗ Hot reload: DISABLED                                  │
│ • Optimized builds                                     │
│ • No unnecessary files                                 │
│ • Usage: docker-compose -f docker-compose.prod.yml up   │
│ • Recommended for: Production deployment               │
└─────────────────────────────────────────────────────────┘
```

---

## Quickest Workflow

```
1. Install Docker
   └─→ docker-setup.sh (Linux/Mac)
       or
       docker-setup.bat (Windows)

2. Start Development
   └─→ make docker-dev
       or
       docker-compose -f docker-compose.dev.yml up

3. Open http://localhost:3000

4. Debug Python Code
   └─→ Press F5 in VS Code
       └─→ Select "Python: Remote Attach (Docker)"
       └─→ Set breakpoint in backend/
       └─→ Make API request to trigger

5. Debug React Code
   └─→ Press F5 (after Python debug running)
       └─→ Select "Chrome: Attach"
       └─→ Open http://localhost:3000
       └─→ Set breakpoint in frontend/src/
       └─→ Reload page to trigger

6. View All Logs
   └─→ docker-compose logs -f

7. Stop Everything
   └─→ docker-compose down
```

---

## Environment Variable Flow

```
Host Machine
    │
    ├─→ .env.docker (template)
    │
    └─→ docker-compose up --env-file .env.docker
            │
            ├─→ DATABASE_URL=postgresql://...
            ├─→ SECRET_KEY=...
            ├─→ DEBUG_MODE=1
            ├─→ REACT_APP_API_URL=...
            │
            ▼
        Backend Container
            └─→ Uses DATABASE_URL, SECRET_KEY
            
        Frontend Container
            └─→ Uses REACT_APP_API_URL, DEBUG_MODE
            
        Database Container
            └─→ Uses DB_USER, DB_PASSWORD, DB_NAME
```

---

## Debugger Ports at a Glance

```
| Service | Port | Type | Connect From |
|---------|------|------|--------------|
| Frontend | 3000 | Web UI | Browser http://localhost:3000 |
| Backend | 8000 | API | http://localhost:8000 |
| API Docs | 8000 | Web UI | http://localhost:8000/docs |
| Python Debugger | 5678 | TCP | VS Code/PyCharm |
| Node Debugger | 9229 | Chrome Protocol | VS Code/Chrome DevTools |
| PostgreSQL | 5432 | TCP | psql client |
```

---

## VS Code Integration

```
.vscode/
├── launch.json
│   ├── Python: Remote Attach (Docker)
│   │   └─→ Connects to port 5678
│   ├── Chrome: Attach (React Frontend)
│   │   └─→ Connects to port 9229
│   └── Compound: Full Stack Debug
│       └─→ Starts both debuggers
│
└── tasks.json
    ├── start-docker-dev
    ├── docker-compose-up
    ├── docker-compose-down
    ├── docker-logs-backend
    └── docker-logs-frontend
```

**Usage:**
- Press `F5` → Select configuration
- Debuggers attach automatically ✅
- Set breakpoints in code
- Reload app/browser to trigger

---

## Key Files Reference

| File | Purpose | Contains |
|------|---------|----------|
| `backend/Dockerfile` | Backend image | Python 3.11, debugpy, FastAPI |
| `frontend/Dockerfile` | Frontend image | Node 18, npm, React |
| `docker-compose.dev.yml` | Dev orchestration | Debuggers always on |
| `.vscode/launch.json` | VS Code debug config | Port 5678, 9229 configs |
| `.vscode/tasks.json` | VS Code tasks | Docker compose commands |
| `.env.docker` | Variables template | Database, API, debug settings |
| `DOCKER_GUIDE.md` | Full documentation | 300+ lines, all features |
| `Makefile` | Quick commands | `make docker-dev`, `make docker-logs` |

---

## 🎯 Summary

✅ **Complete Docker Setup** with Python + Node debuggers
✅ **VS Code Integration** ready to go
✅ **Hot Reload** for both frontend & backend
✅ **PostgreSQL Database** included
✅ **Three Compose Files** for different environments
✅ **Comprehensive Documentation** and quick reference
✅ **Setup Scripts** for Windows, Mac, Linux
✅ **Make Commands** for easy workflow

**Ready to debug?** Start with: `docker-compose -f docker-compose.dev.yml up --build`
