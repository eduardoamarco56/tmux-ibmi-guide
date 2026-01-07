# ============================================
# Script para configurar locale UTF-8 permanentemente
# ============================================

Write-Host ""
Write-Host "========================================"
Write-Host "   Configurar Locale UTF-8 en IBM i"
Write-Host "========================================"
Write-Host ""
Write-Host "Este script configurara el locale UTF-8 permanentemente"
Write-Host "en el perfil de usuario TU_USUARIO"
Write-Host ""
Write-Host "IP: TU_IBM_i_HOST"
Write-Host "Usuario: TU_USUARIO"
Write-Host ""

$confirm = Read-Host "Deseas continuar? (S/N)"

if ($confirm -ne "S" -and $confirm -ne "s") {
    Write-Host "Operacion cancelada." -ForegroundColor Yellow
    Read-Host "Presiona Enter para salir"
    exit 0
}

Write-Host ""
Write-Host "Configurando locale UTF-8..." -ForegroundColor Yellow
Write-Host ""

# Comando para configurar el locale
$command = @"
echo '# Configuracion de locale UTF-8 para tmux' >> ~/.bash_profile
echo 'export LANG=en_US.UTF-8' >> ~/.bash_profile
echo 'export LC_ALL=en_US.UTF-8' >> ~/.bash_profile
echo 'export LC_CTYPE=en_US.UTF-8' >> ~/.bash_profile
echo ''
echo 'Locale UTF-8 configurado en ~/.bash_profile'
echo 'Cierra la sesion y vuelve a conectar para que tome efecto'
"@

ssh TU_USUARIO@TU_IBM_i_HOST $command

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "========================================"
    Write-Host "  Configuracion completada exitosamente"
    Write-Host "========================================"
    Write-Host ""
    Write-Host "IMPORTANTE:" -ForegroundColor Cyan
    Write-Host "1. Cierra todas las sesiones SSH abiertas" -ForegroundColor Yellow
    Write-Host "2. Vuelve a conectar al IBM i" -ForegroundColor Yellow
    Write-Host "3. Ejecuta: .\ejecutar-monitor.ps1" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "El locale UTF-8 estara activo en la proxima sesion" -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "ERROR: No se pudo configurar el locale" -ForegroundColor Red
}

Write-Host ""
Read-Host "Presiona Enter para salir"