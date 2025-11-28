# Setup Trigger Workflow for CI/CD
Write-Host "`n=== Setting up Trigger Workflow CI/CD ===" -ForegroundColor Green

# Backend repo
Write-Host "`n1. Configuring Backend repo..." -ForegroundColor Cyan
cd "D:\DIGITAL WITCH CLASS\CLOUD COMPUTING\ALL PROJECTS\Bank App\main_Bank_app_backend"

if (Test-Path ".github/workflows/cicd.yml") {
    Write-Host "   Removing cicd.yml from backend..." -ForegroundColor Yellow
    git rm .github/workflows/cicd.yml
    git commit -m "Use trigger workflow"
    git push origin main
    Write-Host "   ✓ Backend updated" -ForegroundColor Green
} else {
    Write-Host "   ✓ cicd.yml already removed" -ForegroundColor Green
}

# Test frontend trigger
Write-Host "`n2. Testing Frontend build trigger..." -ForegroundColor Cyan
cd "D:\DIGITAL WITCH CLASS\CLOUD COMPUTING\ALL PROJECTS\Bank App\main_bank_app_frontend"
git commit --allow-empty -m "Test trigger workflow"
git push origin main
Write-Host "   ✓ Frontend build triggered" -ForegroundColor Green

# Test backend trigger
Write-Host "`n3. Testing Backend build trigger..." -ForegroundColor Cyan
cd "D:\DIGITAL WITCH CLASS\CLOUD COMPUTING\ALL PROJECTS\Bank App\main_Bank_app_backend"
git commit --allow-empty -m "Test trigger workflow"
git push origin main
Write-Host "   ✓ Backend build triggered" -ForegroundColor Green

Write-Host "`n=== DONE! ===" -ForegroundColor Green
Write-Host "`nCheck workflow status at:" -ForegroundColor Cyan
Write-Host "https://github.com/kaluifekwe/Bank-App/actions`n" -ForegroundColor White
