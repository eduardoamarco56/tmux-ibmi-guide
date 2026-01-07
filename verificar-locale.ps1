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
scp $verifyScript TU_USUARIO@TU_IBM_i_HOST:/home/TU_USUARIO/

# Dar permisos y ejecutar
Write-Host "Ejecutando verificacion..." -ForegroundColor Yellow
Write-Host ""

ssh TU_USUARIO@TU_IBM_i_HOST "chmod +x /home/TU_USUARIO/verificar-locale.sh && /home/TU_USUARIO/verificar-locale.sh"

Write-Host ""
Write-Host "========================================"
Write-Host "Verificacion completada"
Write-Host "========================================"
Write-Host ""
Read-Host "Presiona Enter para salir"