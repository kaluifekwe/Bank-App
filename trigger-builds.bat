@echo off
echo Triggering CI/CD builds...

REM Trigger frontend build
curl -X POST -H "Accept: application/vnd.github+json" -H "Authorization: Bearer %GITHUB_TOKEN%" https://api.github.com/repos/kaluifekwe/Bank-App/dispatches -d "{\"event_type\":\"frontend-build\",\"client_payload\":{}}"

echo Frontend build triggered

REM Wait 2 seconds
timeout /t 2 /nobreak > nul

REM Trigger backend build
curl -X POST -H "Accept: application/vnd.github+json" -H "Authorization: Bearer %GITHUB_TOKEN%" https://api.github.com/repos/kaluifekwe/Bank-App/dispatches -d "{\"event_type\":\"backend-build\",\"client_payload\":{}}"

echo Backend build triggered

echo.
echo Check workflows at: https://github.com/kaluifekwe/Bank-App/actions
pause
