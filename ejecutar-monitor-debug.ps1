# ============================================
# Script PowerShell para ejecutar monitor DEBUG
# ============================================

Write-Host ""
Write-Host "========================================"
Write-Host "   Ejecutando Monitor DEBUG"
Write-Host "========================================"
Write-Host ""

$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$monitorScript = Join-Path $scriptPath "monitor-tn5250-debug.sh"

# Copiar el script
Write-Host "Copiando script de debug al IBM i..." -ForegroundColor Yellow
scp $monitorScript EAMARCO@192.168.50.225:/home/EAMARCO/

if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: No se pudo copiar el script" -ForegroundColor Red
    Read-Host "Presiona Enter para salir"
    exit 1
}

Write-Host ""
Write-Host "Dando permisos de ejecucion..." -ForegroundColor Yellow
ssh EAMARCO@192.168.50.225 "chmod +x /home/EAMARCO/monitor-tn5250-debug.sh"

Write-Host ""
Write-Host "Ejecutando script de debug..." -ForegroundColor Yellow
Write-Host "Esto mostrara informacion detallada del proceso" -ForegroundColor Cyan
Write-Host ""
Read-Host "Presiona Enter para continuar"

# Conectar y ejecutar el script con locale configurado
ssh -t EAMARCO@192.168.50.225 "export LANG=C; export LC_ALL=C; export LC_CTYPE=C; /home/EAMARCO/monitor-tn5250-debug.sh"

Write-Host ""
Write-Host "Sesion finalizada." -ForegroundColor Green
Read-Host "Presiona Enter para salir"