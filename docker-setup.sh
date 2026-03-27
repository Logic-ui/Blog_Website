#!/bin/bash

# 🐳 Docker Setup Script

echo "=================================="
echo "   Docker Setup for Blog Website"
echo "=================================="
echo ""

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo -e "${BLUE}Docker not found. Installing Docker...${NC}"
    curl -fsSL https://get.docker.com -o get-docker.sh
    chmod +x get-docker.sh
    ./get-docker.sh
    rm get-docker.sh
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo -e "${BLUE}Docker Compose not found. Installing Docker Compose...${NC}"
    sudo curl -L "https://github.com/docker/compose/releases/download/v2.20.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
fi

echo -e "${GREEN}✅ Docker and Docker Compose are installed!${NC}"
echo ""

# Menu
echo -e "${BLUE}Select an option:${NC}"
echo ""
echo "1) Start Development Mode (with debuggers)"
echo "2) Start Production Mode (optimized)"
echo "3) Start with Environment Variables"
echo "4) Build Images Only"
echo "5) Stop All Containers"
echo "6) View Logs"
echo "7) Clean Up Docker"
echo "8) Open VS Code Debugger Documentation"
echo ""

read -p "Choose option (1-8): " choice

case $choice in
  1)
    echo ""
    echo -e "${BLUE}🚀 Starting Development Mode with Debuggers...${NC}"
    echo ""
    echo "Frontend:     http://localhost:3000"
    echo "Backend:      http://localhost:8000"
    echo "API Docs:     http://localhost:8000/docs"
    echo "Python Debugger Port: 5678"
    echo "Node Debugger Port:   9229"
    echo ""
    echo -e "${YELLOW}💡 Press Ctrl+C to stop${NC}"
    echo ""
    docker-compose -f docker-compose.dev.yml up --build
    ;;
  
  2)
    echo ""
    echo -e "${BLUE}🚀 Starting Production Mode...${NC}"
    docker-compose -f docker-compose.prod.yml up --build
    ;;
  
  3)
    echo ""
    read -p "Enter environment file path [.env.docker]: " envfile
    envfile=${envfile:-.env.docker}
    
    if [ ! -f "$envfile" ]; then
        echo -e "${YELLOW}Creating $envfile from template...${NC}"
        cp .env.docker "$envfile"
    fi
    
    echo -e "${BLUE}Starting with $envfile...${NC}"
    docker-compose --env-file "$envfile" up --build
    ;;
  
  4)
    echo ""
    echo -e "${BLUE}Building images...${NC}"
    docker-compose build --no-cache
    echo -e "${GREEN}✅ Build complete!${NC}"
    ;;
  
  5)
    echo ""
    echo -e "${BLUE}Stopping all containers...${NC}"
    docker-compose down
    echo -e "${GREEN}✅ All containers stopped!${NC}"
    ;;
  
  6)
    echo ""
    echo "1) All logs"
    echo "2) Backend logs"
    echo "3) Frontend logs"
    echo "4) Database logs"
    echo ""
    read -p "Choose (1-4): " log_choice
    
    case $log_choice in
      1) docker-compose logs -f ;;
      2) docker-compose logs -f backend ;;
      3) docker-compose logs -f frontend ;;
      4) docker-compose logs -f db ;;
      *) echo "Invalid option!" ;;
    esac
    ;;
  
  7)
    echo ""
    echo -e "${YELLOW}This will remove all Docker containers, images, and volumes!${NC}"
    read -p "Are you sure? (yes/no): " confirm
    
    if [ "$confirm" = "yes" ]; then
        echo -e "${BLUE}Cleaning up Docker...${NC}"
        docker-compose down -v
        docker system prune -a --volumes -f
        echo -e "${GREEN}✅ Docker cleaned up!${NC}"
    else
        echo "Cancelled."
    fi
    ;;
  
  8)
    echo ""
    echo -e "${BLUE}📖 Docker Debugger Guide${NC}"
    echo ""
    echo "1. Start development mode: docker-compose -f docker-compose.dev.yml up"
    echo "2. Open VS Code"
    echo "3. Press F5 to start debugging"
    echo "4. Select debug configuration (Python or Chrome)"
    echo "5. Set breakpoints and reload app"
    echo ""
    echo "Python Debugger: Attach to port 5678"
    echo "Node Debugger: Attach to port 9229"
    echo ""
    ;;
  
  *)
    echo "Invalid option!"
    exit 1
    ;;
esac

echo ""
echo -e "${GREEN}Done!${NC}"
