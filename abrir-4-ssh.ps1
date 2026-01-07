# ============================================
# Script para abrir 4 ventanas SSH al IBM i
# Sin tn5250 - Solo shell bash
# ============================================

Write-Host ""
Write-Host "========================================"
Write-Host "   Abriendo 4 Ventanas SSH"
Write-Host "========================================"
Write-Host ""
Write-Host "IP: 192.168.50.225"
Write-Host "Usuario: EAMARCO"
Write-Host ""
Write-Host "Se abriran 4 ventanas de PowerShell" -ForegroundColor Cyan
Write-Host "Cada una con una sesion SSH al IBM i" -ForegroundColor Cyan
Write-Host ""

$confirm = Read-Host "Continuar? (S/N)"

if ($confirm -ne "S" -and $confirm -ne "s") {
    Write-Host "Operacion cancelada." -ForegroundColor Yellow
    exit 0
}

Write-Host ""
Write-Host "Abriendo ventanas..." -ForegroundColor Yellow

# Ventana 1
Start-Process powershell -ArgumentList "-NoExit", "-Command", "Write-Host '=== SSH Sesion 1 ===' -ForegroundColor Green; ssh EAMARCO@192.168.50.225"

Start-Sleep -Seconds 1

# Ventana 2
Start-Process powershell -ArgumentList "-NoExit", "-Command", "Write-Host '=== SSH Sesion 2 ===' -ForegroundColor Green; ssh EAMARCO@192.168.50.225"

Start-Sleep -Seconds 1

# Ventana 3
Start-Process powershell -ArgumentList "-NoExit", "-Command", "Write-Host '=== SSH Sesion 3 ===' -ForegroundColor Green; ssh EAMARCO@192.168.50.225"

Start-Sleep -Seconds 1

# Ventana 4
Start-Process powershell -ArgumentList "-NoExit", "-Command", "Write-Host '=== SSH Sesion 4 ===' -ForegroundColor Green; ssh EAMARCO@192.168.50.225"

Write-Host ""
Write-Host "========================================"
Write-Host "  4 ventanas SSH abiertas"
Write-Host "========================================"
Write-Host ""
Write-Host "Cada ventana es una sesion SSH al IBM i" -ForegroundColor Cyan
Write-Host "Tendras acceso al shell bash (eamarco@IBMI01...)" -ForegroundColor Cyan
Write-Host ""
Write-Host "Para cerrar: escribe 'exit' en cada ventana" -ForegroundColor Yellow
Write-Host ""
Write-Host "Usa Alt+Tab para cambiar entre ventanas" -ForegroundColor Yellow
Write-Host ""

Read-Host "Presiona Enter para salir"