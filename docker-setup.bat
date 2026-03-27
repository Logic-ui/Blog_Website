@echo off
REM 🐳 Docker Setup Script for Windows

setlocal enabledelayedexpansion

echo ==================================
echo    Docker Setup for Blog Website
echo ==================================
echo.

REM Check if Docker is installed
docker --version >nul 2>&1
if errorlevel 1 (
    echo Docker not found!
    echo Please download and install Docker Desktop from: https://www.docker.com/products/docker-desktop
    echo.
    pause
    exit /b 1
)

echo ✅ Docker is installed!
echo.

REM Check if Docker Compose is installed
docker-compose --version >nul 2>&1
if errorlevel 1 (
    echo ⚠️  Docker Compose not found!
    echo Installing Docker Compose...
    curl -L "https://github.com/docker/compose/releases/download/v2.20.0/docker-compose-Windows-x86_64.exe" -o "%ProgramFiles%\Docker\Docker\resources\bin\docker-compose.exe"
)

:menu
echo.
echo Select an option:
echo.
echo 1) Start Development Mode (with debuggers)
echo 2) Start Production Mode (optimized)
echo 3) Build Images Only
echo 4) Stop All Containers
echo 5) View Logs
echo 6) Clean Up Docker
echo 7) Exit
echo.

set /p choice="Choose option (1-7): "

if "%choice%"=="1" (
    echo.
    echo 🚀 Starting Development Mode with Debuggers...
    echo.
    echo Frontend:     http://localhost:3000
    echo Backend:      http://localhost:8000
    echo API Docs:     http://localhost:8000/docs
    echo.
    echo Press Ctrl+C to stop
    echo.
    docker-compose -f docker-compose.dev.yml up --build
) else if "%choice%"=="2" (
    echo.
    echo 🚀 Starting Production Mode...
    docker-compose -f docker-compose.prod.yml up --build
) else if "%choice%"=="3" (
    echo.
    echo Building images...
    docker-compose build --no-cache
    echo ✅ Build complete!
) else if "%choice%"=="4" (
    echo.
    echo Stopping all containers...
    docker-compose down
    echo ✅ All containers stopped!
) else if "%choice%"=="5" (
    echo.
    echo 1) All logs
    echo 2) Backend logs
    echo 3) Frontend logs
    echo 4) Database logs
    echo.
    set /p log_choice="Choose (1-4): "
    
    if "!log_choice!"=="1" docker-compose logs -f
    if "!log_choice!"=="2" docker-compose logs -f backend
    if "!log_choice!"=="3" docker-compose logs -f frontend
    if "!log_choice!"=="4" docker-compose logs -f db
) else if "%choice%"=="6" (
    echo.
    echo WARNING: This will remove all Docker containers, images, and volumes!
    set /p confirm="Are you sure? (yes/no): "
    
    if "%confirm%"=="yes" (
        echo Cleaning up Docker...
        docker-compose down -v
        docker system prune -a --volumes -f
        echo ✅ Docker cleaned up!
    ) else (
        echo Cancelled.
    )
) else if "%choice%"=="7" (
    exit /b 0
) else (
    echo Invalid option!
    goto menu
)

echo.
echo Done!
pause
