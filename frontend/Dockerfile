# Frontend Dockerfile with Debugger Support
FROM node:18-alpine

WORKDIR /app

# Copy package files
COPY frontend/package*.json ./

# Install dependencies
RUN npm install

# Copy application code
COPY frontend/ .

# Expose ports
EXPOSE 3000 9229

# Environment variable for debugger (default production)
ENV REACT_APP_API_URL=http://localhost:8000

# Default command - production build
# Set NODE_OPTIONS=--inspect to enable debugger
CMD ["sh", "-c", "if [ \"$DEBUG_MODE\" = \"1\" ]; then npm start; else npm run build && npx serve -s build -l 3000; fi"]
