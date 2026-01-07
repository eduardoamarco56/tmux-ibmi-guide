# ============================================
# Script para verificar y corregir locale
# ============================================

Write-Host ""
Write-Host "========================================"
Write-Host "   Verificar y Corregir Locale"
Write-Host "========================================"
Write-Host ""

Write-Host "Verificando configuracion actual..." -ForegroundColor Yellow
Write-Host ""

# Verificar el contenido de .bash_profile
Write-Host "1. Contenido de ~/.bash_profile:" -ForegroundColor Cyan
ssh TU_USUARIO@TU_IBM_i_HOST "cat ~/.bash_profile 2>/dev/null || echo 'Archivo no existe'"

Write-Host ""
Write-Host "2. Locale actual en nueva sesion:" -ForegroundColor Cyan
ssh TU_USUARIO@TU_IBM_i_HOST "bash -l -c 'echo LANG=\$LANG; echo LC_ALL=\$LC_ALL; echo LC_CTYPE=\$LC_CTYPE'"

Write-Host ""
Write-Host "========================================"
Write-Host ""

$fix = Read-Host "Deseas reconfigurar el locale? (S/N)"

if ($fix -eq "S" -or $fix -eq "s") {
    Write-Host ""
    Write-Host "Reconfigurando locale..." -ForegroundColor Yellow
    
    # Eliminar configuraciones anteriores y agregar nuevas
    $command = @"
# Backup del archivo actual
cp ~/.bash_profile ~/.bash_profile.backup 2>/dev/null || true

# Eliminar lineas de locale anteriores
sed -i '/export LANG=/d' ~/.bash_profile 2>/dev/null || true
sed -i '/export LC_ALL=/d' ~/.bash_profile 2>/dev/null || true
sed -i '/export LC_CTYPE=/d' ~/.bash_profile 2>/dev/null || true

# Agregar configuracion de locale al inicio del archivo
echo '# Configuracion de locale UTF-8 para tmux' > ~/.bash_profile.new
echo 'export LANG=en_US.UTF-8' >> ~/.bash_profile.new
echo 'export LC_ALL=en_US.UTF-8' >> ~/.bash_profile.new
echo 'export LC_CTYPE=en_US.UTF-8' >> ~/.bash_profile.new
echo '' >> ~/.bash_profile.new

# Agregar el resto del archivo si existe
cat ~/.bash_profile >> ~/.bash_profile.new 2>/dev/null || true

# Reemplazar el archivo
mv ~/.bash_profile.new ~/.bash_profile

echo ''
echo 'Configuracion actualizada'
cat ~/.bash_profile
"@

    ssh TU_USUARIO@TU_IBM_i_HOST $command
    
    Write-Host ""
    Write-Host "========================================"
    Write-Host "  Configuracion completada"
    Write-Host "========================================"
    Write-Host ""
    Write-Host "Probando con nueva sesion..." -ForegroundColor Yellow
    Write-Host ""
    
    ssh TU_USUARIO@TU_IBM_i_HOST "bash -l -c 'echo LANG=\$LANG; echo LC_ALL=\$LC_ALL; echo LC_CTYPE=\$LC_CTYPE'"
}

Write-Host ""
Read-Host "Presiona Enter para salir"