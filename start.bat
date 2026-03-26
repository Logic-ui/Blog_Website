@echo off
REM Simple startup script for development on Windows

echo.
echo 🚀 Blog Website - Development Startup
echo =====================================
echo.

REM Check Python
echo ✓ Checking Python...
python --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Python not found. Please install Python 3.8+
    pause
    exit /b 1
)

REM Check Node
echo ✓ Checking Node.js...
npm --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Node.js not found. Please install Node.js 14+
    pause
    exit /b 1
)

echo.
echo 📦 Starting Backend...
cd backend

REM Create venv if not exists
if not exist "venv" (
    echo Creating virtual environment...
    python -m venv venv
)

REM Activate venv
call venv\Scripts\activate.bat

REM Install requirements
pip install -q -r requirements.txt

REM Start backend
echo Backend starting on http://localhost:8000
echo Docs available at http://localhost:8000/docs
start python main.py

echo.
echo 📦 Starting Frontend...
cd ..\frontend

REM Install dependencies
if not exist "node_modules" (
    echo Installing frontend dependencies...
    call npm install -q
)

REM Start frontend
echo Frontend starting on http://localhost:3000
call npm start

echo.
echo 👋 Development session ended
pause
