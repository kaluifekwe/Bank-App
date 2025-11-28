# Monitor CI/CD Progress
Write-Host "`n=== CI/CD Pipeline Monitor ===" -ForegroundColor Green

Write-Host "`n1. Checking ECR for new images..." -ForegroundColor Cyan
$frontendImages = aws ecr describe-images --repository-name bank-frontend --region us-east-1 --query 'imageDetails[*].[imageTags[0],imagePushedAt]' --output text 2>$null
$backendImages = aws ecr describe-images --repository-name bank-backendapi --region us-east-1 --query 'imageDetails[*].[imageTags[0],imagePushedAt]' --output text 2>$null

if ($frontendImages) {
    Write-Host "   ✓ Frontend images found in ECR:" -ForegroundColor Green
    Write-Host "   $frontendImages"
} else {
    Write-Host "   ⏳ No frontend images yet (build in progress...)" -ForegroundColor Yellow
}

if ($backendImages) {
    Write-Host "   ✓ Backend images found in ECR:" -ForegroundColor Green
    Write-Host "   $backendImages"
} else {
    Write-Host "   ⏳ No backend images yet (build in progress...)" -ForegroundColor Yellow
}

Write-Host "`n2. Checking pod status..." -ForegroundColor Cyan
kubectl get pods -n bank-app

Write-Host "`n3. Workflow URLs:" -ForegroundColor Cyan
Write-Host "   Frontend trigger: https://github.com/kaluifekwe/bank-app_frontend/actions"
Write-Host "   Backend trigger: https://github.com/kaluifekwe/Bank_app_backend/actions"
Write-Host "   Bank-App builds: https://github.com/kaluifekwe/Bank-App/actions"

Write-Host "`n=== Next Steps ===" -ForegroundColor Green
Write-Host "1. Wait for workflows to complete (~5-10 minutes)"
Write-Host "2. Once images are in ECR, ArgoCD will auto-sync"
Write-Host "3. Pods will restart and pull new images"
Write-Host "4. Check pod status: kubectl get pods -n bank-app"
Write-Host ""
