param(
    [string]$ServiceName
)

# Check if PowerShell-Yaml is installed
if (-not (Get-Module -ListAvailable -Name "powershell-yaml")) {
    Write-Host "[ERROR] Required module 'powershell-yaml' is not installed." -ForegroundColor Red
    Write-Host "Please install it by running:" -ForegroundColor Yellow
    Write-Host "Install-Module -Name powershell-yaml -Repository PSGallery -Scope CurrentUser" -ForegroundColor Cyan
    exit 1
}

function Rebuild-Service {
    param(
        [string]$Service
    )

    Write-Host "[STOP] Stopping $Service container..." -ForegroundColor Yellow
    docker compose rm -fs $Service

    $volumeName = "sbom_${Service}_data"
    $volumeExists = docker volume ls --format "{{.Name}}" | Select-String -Pattern "^${volumeName}$"

    if ($volumeExists) {
        Write-Host "[CLEAN] Removing volume $volumeName..." -ForegroundColor Yellow
        docker volume rm $volumeName
    }

    Write-Host "[BUILD] Rebuilding $Service image..." -ForegroundColor Yellow
    docker compose build --no-cache $Service

    Write-Host "[START] Starting $Service..." -ForegroundColor Yellow
    docker compose up $Service -d

    Write-Host "[DONE] $Service has been rebuilt and restarted!" -ForegroundColor Green
}

function Rebuild-All {
    Write-Host "[STOP] Stopping all containers and removing volumes..." -ForegroundColor Yellow
    docker compose down -v

    Write-Host "[BUILD] Rebuilding all images..." -ForegroundColor Yellow
    docker compose build --no-cache

    Write-Host "[START] Starting all services..." -ForegroundColor Yellow
    docker compose up -d

    Write-Host "[DONE] All services have been rebuilt and restarted!" -ForegroundColor Green
}

Import-Module powershell-yaml

$services = @()
try {
    $composeContent = Get-Content "docker-compose.yaml" -Raw
    $yaml = ConvertFrom-Yaml $composeContent
    $services = $yaml.services.Keys
} catch {
    Write-Host "[WARN] Could not read docker-compose.yaml. Service validation will be skipped." -ForegroundColor Yellow
}

if ($ServiceName) {
    if ($services -and $services -notcontains $ServiceName) {
        Write-Host "[ERROR] '$ServiceName' is not a valid service in docker-compose.yaml" -ForegroundColor Red
        Write-Host "Available services: $($services -join ', ')" -ForegroundColor Yellow
        exit 1
    }

    Rebuild-Service -Service $ServiceName
} else {
    Write-Host "Are you sure you want to rebuild all services? (Y/n)" -ForegroundColor Yellow

    $choice = Read-Host
    
    if ($choice -eq "n" -or $choice -eq "N") {
        Write-Host "[EXIT] No changes made." -ForegroundColor Cyan
        exit
    } else {
        Rebuild-All
    }
}
