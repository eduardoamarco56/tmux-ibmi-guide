# ============================================
# Script PowerShell FINAL para 4 ventanas TN5250
# Con locale forzado en bash login shell
# ============================================

Write-Host ""
Write-Host "========================================"
Write-Host "   Ejecutando 4 Ventanas TN5250"
Write-Host "   (Con locale UTF-8 forzado)"
Write-Host "========================================"
Write-Host ""
Write-Host "IP: TU_IBM_i_HOST"
Write-Host "Usuario: TU_USUARIO"
Write-Host ""

$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$monitorScript = Join-Path $scriptPath "monitor-tn5250.sh"

# Copiar el script al IBM i
Write-Host "[1/3] Copiando script al IBM i..." -ForegroundColor Yellow
scp $monitorScript TU_USUARIO@TU_IBM_i_HOST:/home/TU_USUARIO/

if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: No se pudo copiar el script" -ForegroundColor Red
    Read-Host "Presiona Enter para salir"
    exit 1
}

Write-Host ""
Write-Host "[2/3] Dando permisos de ejecucion..." -ForegroundColor Yellow
ssh TU_USUARIO@TU_IBM_i_HOST "chmod +x /home/TU_USUARIO/monitor-tn5250.sh"

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

# Conectar y ejecutar con bash login shell y locale forzado
ssh -t TU_USUARIO@TU_IBM_i_HOST "bash -l -c 'export LANG=en_US.UTF-8; export LC_ALL=en_US.UTF-8; export LC_CTYPE=en_US.UTF-8; /home/TU_USUARIO/monitor-tn5250.sh'"

Write-Host ""
Write-Host "Sesion finalizada." -ForegroundColor Green
Read-Host "Presiona Enter para salir"