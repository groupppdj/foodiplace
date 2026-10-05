@echo off
setlocal

echo ==========================================
echo       FoodHub GitHub Push Assistant       
echo ==========================================

set REPO_URL=%1

git remote | findstr /r "^origin$" >nul
if %errorlevel% equ 0 (
    echo Remote origin already configured.
    if not "%REPO_URL%"=="" (
        git remote set-url origin %REPO_URL%
        echo Updated origin to: %REPO_URL%
    fi
) else (
    if "%REPO_URL%"=="" (
        set /p REPO_URL="Enter your GitHub Repository URL: "
    )
    if "%REPO_URL%"=="" (
        echo Error: Repository URL is required.
        exit /b 1
    )
    git remote add origin %REPO_URL%
    echo Added remote origin: %REPO_URL%
)

git branch -M main
echo Staging all files...
git add .
git commit -m "Update project files"
echo Pushing to GitHub...
git push -u origin main

echo ==========================================
echo  Successfully pushed to GitHub!           
echo ==========================================
