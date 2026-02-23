@echo off
setlocal

set IMAGE_NAME=ghcr.io/densy07/librechat-dev-api
set TAG=%1
if "%TAG%"=="" set TAG=latest
set FULL_IMAGE=%IMAGE_NAME%:%TAG%

echo.
echo ========================================
echo   LibreChat API - Build ^& Push
echo ========================================
echo.

:: --- Step 1: Build ---
echo [1/2] Building image: %FULL_IMAGE% ...
docker build -f Dockerfile.multi --target api-build -t %FULL_IMAGE% .
if %ERRORLEVEL% neq 0 (
    echo Build failed!
    exit /b 1
)
echo [1/2] Build completed.
echo.

:: --- Step 2: Push ---
echo [2/2] Pushing %FULL_IMAGE% ...
docker push %FULL_IMAGE%
if %ERRORLEVEL% neq 0 (
    echo Push failed!
    exit /b 1
)
echo [2/2] Push completed.
echo.

:: --- Done ---
echo ========================================
echo   Done! Image pushed: %FULL_IMAGE%
echo ========================================
echo.
echo On your server, run:
echo   docker pull %FULL_IMAGE%
echo   docker compose -f deploy-compose.yml -f deploy-compose.override.yml up -d api
echo.
