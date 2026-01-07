# ============================================
# Script PowerShell para ejecutar 4 ventanas TN5250
# ============================================

Write-Host ""
Write-Host "========================================"
Write-Host "   Ejecutando 4 Ventanas TN5250"
Write-Host "========================================"
Write-Host ""
Write-Host "IP: 192.168.50.225"
Write-Host "Usuario: EAMARCO"
Write-Host ""

# Obtener la ruta del script
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$monitorScript = Join-Path $scriptPath "monitor-tn5250.sh"

# Verificar que el script existe
if (-not (Test-Path $monitorScript)) {
    Write-Host "ERROR: No se encuentra monitor-tn5250.sh" -ForegroundColor Red
    Read-Host "Presiona Enter para salir"
    exit 1
}

# Copiar el script al IBM i
Write-Host "[1/3] Copiando script al IBM i..." -ForegroundColor Yellow
scp $monitorScript EAMARCO@192.168.50.225:/home/EAMARCO/

if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: No se pudo copiar el script" -ForegroundColor Red
    Read-Host "Presiona Enter para salir"
    exit 1
}

Write-Host ""
Write-Host "[2/3] Dando permisos de ejecucion..." -ForegroundColor Yellow
ssh EAMARCO@192.168.50.225 "chmod +x /home/EAMARCO/monitor-tn5250.sh"

Write-Host ""
Write-Host "[3/3] Ejecutando 4 ventanas TN5250..." -ForegroundColor Yellow
Write-Host ""
Write-Host "IMPORTANTE: Se abriran 4 ventanas TN5250 en tmux" -ForegroundColor Cyan
Write-Host "Comandos utiles:" -ForegroundColor Cyan
Write-Host "  Ctrl+b 0-3  : Cambiar entre ventanas TN5250" -ForegroundColor Cyan
Write-Host "  Ctrl+b d    : Desconectar (sesiones siguen activas)" -ForegroundColor Cyan
Write-Host "  Ctrl+b x    : Cerrar ventana actual" -ForegroundColor Cyan
Write-Host ""
Read-Host "Presiona Enter para continuar"

# Conectar y ejecutar el script con locale configurado
ssh -t EAMARCO@192.168.50.225 "export LANG=C; export LC_ALL=C; export LC_CTYPE=C; /home/EAMARCO/monitor-tn5250.sh"

Write-Host ""
Write-Host "Sesion finalizada." -ForegroundColor Green
Read-Host "Presiona Enter para salir"