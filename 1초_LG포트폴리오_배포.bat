@echo off
chcp 65001 > nul
echo ========================================================
echo   LG 포트폴리오 1초 배포 스크립트
echo ========================================================

set TARGET_DIR="C:\Users\cob\Desktop\취업자료26\지원서\lg 지원서"
cd /d %TARGET_DIR%

if exist .deploy_temp rmdir /s /q .deploy_temp
mkdir .deploy_temp

copy "index.html" ".deploy_temp\index.html" > nul
if exist "assets" xcopy "assets" ".deploy_temp\assets" /E /I /H /Y > nul
copy ".nojekyll" ".deploy_temp\.nojekyll" > nul

cd .deploy_temp
call git init
call git add .
call git commit -m "Deploy LG Portfolio"
call git branch -M main

call gh repo create wkdehdgus0328-wq/lg-portfolio --public 2>nul
call git remote add origin https://github.com/wkdehdgus0328-wq/lg-portfolio.git
call git push -f origin main

if %errorlevel% neq 0 (
    echo [에러] 배포 중 오류가 발생했습니다.
    cd ..
    exit /b %errorlevel%
)

cd ..
rmdir /s /q .deploy_temp
echo 배포 완료. URL: https://wkdehdgus0328-wq.github.io/lg-portfolio/
