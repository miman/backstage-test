@echo off
setlocal

echo ========================================================
echo   Backstage Docker Installer
echo ========================================================

IF EXIST "backstage-app" (
    echo [INFO] "backstage-app" directory already exists.
    echo [INFO] Pulling latest changes from official repo...
    pushd backstage-app
    REM If there's a local .dockerignore, discard local changes so git pull won't fail
    if exist ".dockerignore" (
        echo [INFO] Discarding local changes to .dockerignore
        git checkout -- .dockerignore 2>nul || git restore .dockerignore 2>nul
    )
    git pull
) ELSE (
    echo [INFO] Cloning official Backstage repository...
    echo [INFO] Source: https://github.com/backstage/backstage.git
    git clone https://github.com/backstage/backstage.git backstage-app
    pushd backstage-app
)

IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Git clone/pull failed.
    pause
    exit /b 1
)

echo.
echo [INFO] Patching .dockerignore for source build...
copy /Y ..\source.dockerignore .dockerignore

echo.
echo [INFO] Copying app-config.local.yaml into backstage-app (Docker build context)...
if exist "..\app-config.local.yaml" (
    copy /Y ..\app-config.local.yaml app-config.local.yaml >nul
) else (
    echo [WARN] ..\app-config.local.yaml not found. Docker will fail if docker-compose.yaml references it.
)
popd


echo.
echo [INFO] Using 'packages/backend/Dockerfile' from the repo.
echo [INFO] Starting Docker Compose...
echo [INFO] This will build the application from source. It may take 10-15 minutes.
echo.

docker-compose up -d --build

IF NOT ERRORLEVEL 1 (
    echo.
    echo [SUCCESS] Backstage is starting!
    echo [INFO] URL: http://localhost:7007
    echo [INFO] Weather Proxy: http://localhost:3001
    echo.
    echo [NOTE] It may take a few minutes for the containers to fully initialize.
) ELSE (
    echo [ERROR] Docker Compose failed to start.
)

pause
