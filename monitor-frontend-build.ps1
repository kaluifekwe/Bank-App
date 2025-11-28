# Monitor Frontend CI/CD Progress
$maxAttempts = 20
$attempt = 0

Write-Host "`n=== Monitoring Frontend CI/CD ===" -ForegroundColor Green

while ($attempt -lt $maxAttempts) {
    $attempt++
    Write-Host "`n[$attempt/$maxAttempts] Checking... ($(Get-Date -Format 'HH:mm:ss'))" -ForegroundColor Cyan
    
    # Check ECR
    Write-Host "  Checking ECR for images..." -ForegroundColor Yellow
    $images = aws ecr list-images --repository-name bank-frontend --region us-east-1 --query 'imageIds[*].imageTag' --output text
    if ($images) {
        Write-Host "  ✅ Images found in ECR: $images" -ForegroundColor Green
        break
    } else {
        Write-Host "  ⏳ No images yet" -ForegroundColor Gray
    }
    
    # Check manifest
    Write-Host "  Checking manifest repo for updates..." -ForegroundColor Yellow
    cd "d:\DIGITAL WITCH CLASS\CLOUD COMPUTING\ALL PROJECTS\Bank App\kubernetes-manifest"
    git fetch -q
    $latestCommit = git log origin/main --oneline -1
    Write-Host "  Latest: $latestCommit" -ForegroundColor Gray
    
    if ($attempt -lt $maxAttempts) {
        Write-Host "  Waiting 15 seconds..." -ForegroundColor Gray
        Start-Sleep -Seconds 15
    }
}

Write-Host "`n=== Final Status ===" -ForegroundColor Green
aws ecr describe-images --repository-name bank-frontend --region us-east-1 --query 'imageDetails[*].[imageTags[0],imagePushedAt]' --output table

Write-Host "`nCheck workflows at:" -ForegroundColor Cyan
Write-Host "https://github.com/kaluifekwe/Bank-App/actions" -ForegroundColor White
