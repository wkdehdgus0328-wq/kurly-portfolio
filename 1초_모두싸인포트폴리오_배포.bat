@echo off
chcp 65001 > nul
echo ========================================================
echo   모두싸인 포트폴리오 1초 배포 스크립트
echo ========================================================

set TARGET_DIR="C:\Users\cob\Desktop\취업자료26\지원서\모두싸인 지원서"
cd /d %TARGET_DIR%

if exist .deploy_temp rmdir /s /q .deploy_temp
mkdir .deploy_temp

copy "index.html" ".deploy_temp\index.html" > nul
if exist "assets" xcopy "assets" ".deploy_temp\assets" /E /I /H /Y > nul
if exist ".nojekyll" copy ".nojekyll" ".deploy_temp\.nojekyll" > nul
if not exist ".nojekyll" type nul > ".deploy_temp\.nojekyll"

cd .deploy_temp
call git init
call git add .
call git commit -m "Deploy Modusign Portfolio"
call git branch -M main

call gh repo create wkdehdgus0328-wq/modusign-portfolio --public 2>nul
call git remote add origin https://github.com/wkdehdgus0328-wq/modusign-portfolio.git
call git push -f origin main

call gh api --method POST /repos/wkdehdgus0328-wq/modusign-portfolio/pages -f "source[branch]=main" -f "source[path]=/" 2>nul

if %errorlevel% neq 0 (
    echo [에러] 배포 중 오류가 발생했습니다.
    cd ..
    exit /b %errorlevel%
)

cd ..
rmdir /s /q .deploy_temp
echo 배포 완료. URL: https://wkdehdgus0328-wq.github.io/modusign-portfolio/
