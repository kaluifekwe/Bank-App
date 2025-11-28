# Diagnostic script to check GitHub runner configuration
Write-Host "`n=== GitHub Runner Diagnostic ===" -ForegroundColor Green

Write-Host "`nTo diagnose the issue, please run these commands on your EC2 instance:" -ForegroundColor Cyan
Write-Host "ssh -i your-key.pem ubuntu@13.216.202.83" -ForegroundColor Yellow

Write-Host "`n1. Check if AWS CLI is configured on runner:" -ForegroundColor Cyan
Write-Host "   docker exec github-runner aws sts get-caller-identity"

Write-Host "`n2. Check if Docker is working:" -ForegroundColor Cyan  
Write-Host "   docker exec github-runner docker ps"

Write-Host "`n3. Check runner logs for errors:" -ForegroundColor Cyan
Write-Host "   docker logs github-runner --tail 100"

Write-Host "`n4. Check if runner has network access:" -ForegroundColor Cyan
Write-Host "   docker exec github-runner ping -c 3 google.com"

Write-Host "`n=== Most Likely Issues ===" -ForegroundColor Yellow
Write-Host "1. AWS credentials not configured in runner"
Write-Host "2. GIT_USERNAME and GIT_PASSWORD secrets missing in Bank-App repo"
Write-Host "3. Docker socket not mounted correctly"

Write-Host "`n=== Quick Fix ===" -ForegroundColor Green
Write-Host "Configure AWS credentials on the runner:"
Write-Host "docker exec -it github-runner bash"
Write-Host "aws configure"
Write-Host "  AWS Access Key ID: [your-key]"
Write-Host "  AWS Secret Access Key: [your-secret]"
Write-Host "  Default region: us-east-1"
Write-Host ""
