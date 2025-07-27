@echo off
echo ========================================
echo    AI Creative Platform - Windows Deploy
echo ========================================
echo.

:: Check admin privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] Please run this script as administrator
    echo Right-click the script file and select "Run as administrator"
    pause
    exit /b 1
)

:: Switch to project root directory
cd /d "%~dp0\..\..\"

:: Check if Docker is installed
echo [1/6] Checking Docker installation...
docker --version >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] Docker is not installed or not running
    echo.
    echo Please follow these steps to install Docker Desktop:
    echo 1. Visit https://www.docker.com/products/docker-desktop/
    echo 2. Download Docker Desktop for Windows
    echo 3. Run the installer and restart your computer
    echo 4. Start Docker Desktop
    echo.
    pause
    exit /b 1
)
echo [OK] Docker is installed

:: Check Docker Compose
docker-compose --version >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] Docker Compose is not installed
    pause
    exit /b 1
)
echo [OK] Docker Compose is installed

:: Check Git (optional)
echo [2/6] Checking Git installation...
git --version >nul 2>&1
if %errorLevel% neq 0 (
    echo [WARNING] Git is not installed, recommend installing Git for future updates
    echo Download: https://git-scm.com/download/win
) else (
    echo [OK] Git is installed
)

:: Create environment variables file
echo [3/6] Configuring environment variables...
if not exist .env (
    if exist .env.example (
        copy .env.example .env >nul
        echo [OK] Created .env file from template
    ) else (
        echo [CREATE] Generating default .env file...
        echo # AI Creative Platform Environment Configuration > .env
        echo. >> .env
        echo # Application Configuration >> .env
        echo APP_ENV=production >> .env
        echo APP_PORT=8080 >> .env
        echo FRONTEND_PORT=3000 >> .env
        echo. >> .env
        echo # Database Configuration >> .env
        echo POSTGRES_DB=ai_creative_platform >> .env
        echo POSTGRES_USER=postgres >> .env
        echo POSTGRES_PASSWORD=ai_creative_2025 >> .env
        echo POSTGRES_HOST=postgres >> .env
        echo POSTGRES_PORT=5432 >> .env
        echo. >> .env
        echo # Redis Configuration >> .env
        echo REDIS_HOST=redis >> .env
        echo REDIS_PORT=6379 >> .env
        echo REDIS_PASSWORD=redis_password_2025 >> .env
        echo. >> .env
        echo # JWT Configuration >> .env
        echo JWT_SECRET=your_jwt_secret_key_change_this_in_production >> .env
        echo JWT_EXPIRES_IN=24h >> .env
        echo. >> .env
        echo # OpenAI Configuration (Optional) >> .env
        echo OPENAI_API_KEY=your_openai_api_key_here >> .env
        echo. >> .env
        echo # Qdrant Configuration >> .env
        echo QDRANT_HOST=qdrant >> .env
        echo QDRANT_PORT=6333 >> .env
        echo. >> .env
        echo # Monitoring Configuration >> .env
        echo GRAFANA_ADMIN_PASSWORD=admin123 >> .env
        echo [OK] Generated default .env file
    )
) else (
    echo [OK] .env file already exists
)

:: Prompt user to configure OpenAI API Key
echo.
echo [IMPORTANT] Please edit .env file to configure your OpenAI API Key:
echo 1. Open .env file
echo 2. Replace OPENAI_API_KEY=your_openai_api_key_here with your real API Key
echo 3. Save the file
echo.
set /p continue="Have you configured it? (y/n): "
if /i "%continue%" neq "y" (
    echo Opening .env file...
    notepad .env
    echo.
    set /p continue="Press any key to continue after configuration..."
)

:: Pull Docker images
echo [4/6] Pulling Docker images...
echo This may take a few minutes, please wait...
docker-compose pull
if %errorLevel% neq 0 (
    echo [ERROR] Failed to pull images
    pause
    exit /b 1
)
echo [OK] Images pulled successfully

:: Build and start services
echo [5/6] Building and starting services...
docker-compose up -d --build
if %errorLevel% neq 0 (
    echo [ERROR] Failed to start services
    echo Please check if Docker Desktop is running properly
    pause
    exit /b 1
)
echo [OK] Services started successfully

:: Wait for services to be ready
echo [6/6] Waiting for services to be ready...
timeout /t 10 /nobreak >nul

:: Check service status
echo.
echo Checking service status:
docker-compose ps

:: Health check
echo.
echo Performing health check...
timeout /t 5 /nobreak >nul

:: Try to access backend health check
curl -s http://localhost:8080/health >nul 2>&1
if %errorLevel% equ 0 (
    echo [OK] Backend service is healthy
) else (
    echo [WARNING] Backend service may still be starting
)

:: Display access information
echo.
echo ========================================
echo           Deployment Complete!
echo ========================================
echo.
echo Service Access URLs:
echo Frontend App:    http://localhost:3000
echo Backend API:     http://localhost:8080
echo API Docs:        http://localhost:8080/docs
echo Database Admin:  http://localhost:8081
echo Monitoring:      http://localhost:3001
echo.
echo Default Login Info:
echo Database Admin: Username: postgres, Password: ai_creative_2025
echo Monitoring:     Username: admin,    Password: admin123
echo.
echo Common Commands:
echo View logs:       docker-compose logs -f
echo Stop services:   docker-compose down
echo Restart services: docker-compose restart
echo Troubleshoot:    deploy\windows\troubleshoot.bat
echo.

:: Ask if user wants to open browser
set /p open_browser="Open browser to access the application? (y/n): "
if /i "%open_browser%"=="y" (
    start http://localhost:3000
)

echo.
echo Deployment complete! If you have any issues, please check README.md
pause