#!/bin/bash
# Simple startup script for development

echo "🚀 Blog Website - Development Startup"
echo "======================================"
echo ""

# Check Python
echo "✓ Checking Python..."
if ! command -v python &> /dev/null; then
    echo "❌ Python not found. Please install Python 3.8+"
    exit 1
fi

# Check Node
echo "✓ Checking Node.js..."
if ! command -v npm &> /dev/null; then
    echo "❌ Node.js not found. Please install Node.js 14+"
    exit 1
fi

echo ""
echo "📦 Starting Backend..."
cd backend

# Create venv if not exists
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python -m venv venv
fi

# Activate venv
source venv/bin/activate 2>/dev/null || source venv/Scripts/activate

# Install requirements
pip install -q -r requirements.txt

# Start backend
echo "Backend starting on http://localhost:8000"
echo "Docs available at http://localhost:8000/docs"
python main.py &
BACKEND_PID=$!

echo ""
echo "📦 Starting Frontend..."
cd ../frontend

# Install dependencies
if [ ! -d "node_modules" ]; then
    echo "Installing frontend dependencies..."
    npm install -q
fi

# Start frontend
echo "Frontend starting on http://localhost:3000"
npm start

# Cleanup
kill $BACKEND_PID 2>/dev/null

echo ""
echo "👋 Development session ended"
