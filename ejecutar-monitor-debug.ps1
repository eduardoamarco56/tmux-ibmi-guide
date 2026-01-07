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
scp $monitorScript TU_USUARIO@TU_IBM_i_HOST:/home/TU_USUARIO/

if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: No se pudo copiar el script" -ForegroundColor Red
    Read-Host "Presiona Enter para salir"
    exit 1
}

Write-Host ""
Write-Host "Dando permisos de ejecucion..." -ForegroundColor Yellow
ssh TU_USUARIO@TU_IBM_i_HOST "chmod +x /home/TU_USUARIO/monitor-tn5250-debug.sh"

Write-Host ""
Write-Host "Ejecutando script de debug..." -ForegroundColor Yellow
Write-Host "Esto mostrara informacion detallada del proceso" -ForegroundColor Cyan
Write-Host ""
Read-Host "Presiona Enter para continuar"

# Conectar y ejecutar el script con locale configurado
ssh -t TU_USUARIO@TU_IBM_i_HOST "export LANG=C; export LC_ALL=C; export LC_CTYPE=C; /home/TU_USUARIO/monitor-tn5250-debug.sh"

Write-Host ""
Write-Host "Sesion finalizada." -ForegroundColor Green
Read-Host "Presiona Enter para salir"