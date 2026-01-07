# ============================================
# Script para verificar locales en IBM i
# ============================================

Write-Host ""
Write-Host "========================================"
Write-Host "   Verificando Locales en IBM i"
Write-Host "========================================"
Write-Host ""

$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$verifyScript = Join-Path $scriptPath "verificar-locale.sh"

# Copiar el script
Write-Host "Copiando script de verificacion..." -ForegroundColor Yellow
scp $verifyScript EAMARCO@192.168.50.225:/home/EAMARCO/

# Dar permisos y ejecutar
Write-Host "Ejecutando verificacion..." -ForegroundColor Yellow
Write-Host ""

ssh EAMARCO@192.168.50.225 "chmod +x /home/EAMARCO/verificar-locale.sh && /home/EAMARCO/verificar-locale.sh"

Write-Host ""
Write-Host "========================================"
Write-Host "Verificacion completada"
Write-Host "========================================"
Write-Host ""
Read-Host "Presiona Enter para salir"