# Backend Dockerfile with Debugger Support
FROM python:3.11-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first for better caching
COPY backend/requirements.txt .

# Install Python dependencies including debugger
RUN pip install --no-cache-dir -r requirements.txt && \
    pip install --no-cache-dir debugpy

# Copy application code
COPY backend/ .

# Expose ports
EXPOSE 8000 5678

# Default command runs with debugger
# Set DEBUG_MODE=1 to enable debugger
CMD ["sh", "-c", "if [ \"$DEBUG_MODE\" = \"1\" ]; then python -m debugpy --listen 0.0.0.0:5678 -m uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload; else uvicorn app.main:app --host 0.0.0.0 --port 8000; fi"]
