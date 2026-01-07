# ============================================
# Script para abrir 4 ventanas TN5250
# Sin tmux/screen - Usando multiples sesiones SSH
# ============================================

Write-Host ""
Write-Host "========================================"
Write-Host "   Abriendo 4 Ventanas TN5250"
Write-Host "========================================"
Write-Host ""
Write-Host "IP: TU_IBM_i_HOST"
Write-Host "Usuario: TU_USUARIO"
Write-Host ""
Write-Host "Se abriran 4 ventanas de PowerShell" -ForegroundColor Cyan
Write-Host "Cada una con una sesion TN5250" -ForegroundColor Cyan
Write-Host ""

$confirm = Read-Host "Continuar? (S/N)"

if ($confirm -ne "S" -and $confirm -ne "s") {
    Write-Host "Operacion cancelada." -ForegroundColor Yellow
    exit 0
}

Write-Host ""
Write-Host "Abriendo ventanas..." -ForegroundColor Yellow

# Ventana 1
Start-Process powershell -ArgumentList "-NoExit", "-Command", "Write-Host 'TN5250 Ventana 1' -ForegroundColor Green; ssh -t TU_USUARIO@TU_IBM_i_HOST 'tn5250 TU_IBM_i_HOST'"

Start-Sleep -Seconds 1

# Ventana 2
Start-Process powershell -ArgumentList "-NoExit", "-Command", "Write-Host 'TN5250 Ventana 2' -ForegroundColor Green; ssh -t TU_USUARIO@TU_IBM_i_HOST 'tn5250 TU_IBM_i_HOST'"

Start-Sleep -Seconds 1

# Ventana 3
Start-Process powershell -ArgumentList "-NoExit", "-Command", "Write-Host 'TN5250 Ventana 3' -ForegroundColor Green; ssh -t TU_USUARIO@TU_IBM_i_HOST 'tn5250 TU_IBM_i_HOST'"

Start-Sleep -Seconds 1

# Ventana 4
Start-Process powershell -ArgumentList "-NoExit", "-Command", "Write-Host 'TN5250 Ventana 4' -ForegroundColor Green; ssh -t TU_USUARIO@TU_IBM_i_HOST 'tn5250 TU_IBM_i_HOST'"

Write-Host ""
Write-Host "========================================"
Write-Host "  4 ventanas TN5250 abiertas"
Write-Host "========================================"
Write-Host ""
Write-Host "Cada ventana es una sesion SSH independiente" -ForegroundColor Cyan
Write-Host "Para cerrar: escribe 'exit' en cada ventana" -ForegroundColor Cyan
Write-Host ""
Write-Host "Ventajas:" -ForegroundColor Yellow
Write-Host "  - No requiere tmux ni screen" -ForegroundColor Green
Write-Host "  - Funciona sin problemas de locale" -ForegroundColor Green
Write-Host "  - Cada sesion es independiente" -ForegroundColor Green
Write-Host ""
Write-Host "Desventajas:" -ForegroundColor Yellow
Write-Host "  - Las sesiones no persisten si cierras Windows" -ForegroundColor Red
Write-Host "  - Necesitas Alt+Tab para cambiar entre ventanas" -ForegroundColor Red
Write-Host ""

Read-Host "Presiona Enter para salir"