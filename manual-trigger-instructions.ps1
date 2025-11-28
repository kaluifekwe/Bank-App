# Manually trigger Bank-App CI/CD workflows
# Since trigger workflows aren't working, we'll manually dispatch the workflows

Write-Host "`n=== Manually Triggering CI/CD Workflows ===" -ForegroundColor Green

# You need to get a GitHub Personal Access Token with 'repo' and 'workflow' permissions
# Then set it: $env:GITHUB_TOKEN = "your_token_here"

Write-Host "`nMethod 1: Use GitHub Web UI (Easiest)" -ForegroundColor Cyan
Write-Host "1. Go to: https://github.com/kaluifekwe/Bank-App/actions/workflows/frontend-cicd.yml"
Write-Host "2. Click 'Run workflow' dropdown button"
Write-Host "3. Select branch: main"
Write-Host "4. Click 'Run workflow' green button"
Write-Host ""
Write-Host "5. Go to: https://github.com/kaluifekwe/Bank-App/actions/workflows/backend-cicd.yml"
Write-Host "6. Click 'Run workflow' and run it"

Write-Host "`nMethod 2: Use GitHub CLI (if installed)" -ForegroundColor Cyan
Write-Host "gh workflow run frontend-cicd.yml --repo kaluifekwe/Bank-App"
Write-Host "gh workflow run backend-cicd.yml --repo kaluifekwe/Bank-App"

Write-Host "`nMethod 3: Fix trigger workflows (permanent solution)" -ForegroundColor Cyan
Write-Host "The GIT_PASSWORD secret in frontend/backend repos needs to be updated"
Write-Host "1. Go to each repo settings -> Secrets and variables -> Actions"
Write-Host "2. Update GIT_PASSWORD with a valid GitHub Personal Access Token"
Write-Host "3. Token needs 'repo' scope to trigger workflows"

Write-Host "`n=== Recommended: Use Method 1 (Web UI) ===" -ForegroundColor Yellow
Write-Host "It's the quickest way to trigger both workflows right now!`n"
