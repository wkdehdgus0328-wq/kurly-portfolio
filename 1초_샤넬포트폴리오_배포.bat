@echo off
chcp 65001 > nul
echo ========================================================
echo   샤넬 포트폴리오 1초 배포 스크립트
echo ========================================================
echo.

set TARGET_DIR="C:\Users\cob\Desktop\취업자료26\지원서\샤넬 지원서"
cd /d %TARGET_DIR%

echo [1/3] 기존 배포용 폴더(.deploy_temp) 정리 중...
if exist .deploy_temp rmdir /s /q .deploy_temp
mkdir .deploy_temp

echo [2/3] 포트폴리오 파일 복사 중...
copy "샤넬 포트폴리오.html" ".deploy_temp\index.html" > nul
if exist "assets" xcopy "assets" ".deploy_temp\assets" /E /I /H /Y > nul

cd .deploy_temp
echo [3/3] GitHub에 업로드 중...
call git init
call git add .
call git commit -m "Deploy Chanel Portfolio"
call git branch -M main
call git remote add origin https://github.com/wkdehdgus0328-wq/chanel-portfolio.git
call git push -f origin main

if %errorlevel% neq 0 (
    echo [에러] 배포 중 오류가 발생했습니다.
    cd ..
    pause
    exit /b %errorlevel%
)

cd ..
rmdir /s /q .deploy_temp

echo.
echo ========================================================
echo   포트폴리오 배포가 성공적으로 완료되었습니다!
echo   약 1~2분 뒤 반영됩니다.
echo   URL: https://wkdehdgus0328-wq.github.io/chanel-portfolio/
echo ========================================================
pause
