@echo off
REM ============================================
REM Script de Validación de tmux en IBM i (Windows)
REM ============================================
REM Este script verifica si tmux está disponible
REM en el IBM i desde Windows
REM ============================================

setlocal enabledelayedexpansion

REM Configuración - EDITAR ESTOS VALORES
set IBM_HOST=your_ibmi_host
set IBM_USER=your_username

echo ============================================
echo Validacion de tmux en IBM i
echo ============================================
echo.
echo Host: %IBM_HOST%
echo Usuario: %IBM_USER%
echo.

echo ============================================
echo PASO 1: Verificando conectividad
echo ============================================

ping -n 1 -w 2000 %IBM_HOST% >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] Host %IBM_HOST% es alcanzable
) else (
    echo [ERROR] No se puede alcanzar el host %IBM_HOST%
    echo.
    echo Verifica que:
    echo   - El servidor IBM i este encendido
    echo   - La IP sea correcta
    echo   - No haya firewall bloqueando
    pause
    exit /b 1
)

echo.
echo ============================================
echo PASO 2: Verificando SSH
echo ============================================
echo.
echo Buscando cliente SSH...

REM Verificar si ssh está disponible
where ssh >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Cliente SSH no encontrado
    echo.
    echo Necesitas instalar un cliente SSH:
    echo   - Windows 10/11: OpenSSH viene incluido
    echo   - Habilitar en: Configuracion ^> Aplicaciones ^> Caracteristicas opcionales
    echo   - O instalar: PuTTY, Git Bash, WSL
    pause
    exit /b 1
)

echo [OK] Cliente SSH encontrado
echo.

echo ============================================
echo PASO 3: Conectando al IBM i
echo ============================================
echo.
echo NOTA: Se te pedira la contrasena del usuario %IBM_USER%
echo.
pause

REM Crear script temporal
set TEMP_SCRIPT=%TEMP%\ibmi_check.sh
(
echo #!/bin/bash
echo echo "=== Informacion del Sistema ==="
echo echo "Hostname: $(hostname)"
echo echo "Sistema Operativo: $(uname -s)"
echo echo "Version: $(uname -r)"
echo echo ""
echo echo "=== Verificando PASE ==="
echo if [ -d "/QOpenSys" ]; then
echo     echo "[OK] Directorio PASE encontrado: /QOpenSys"
echo else
echo     echo "[ERROR] Directorio PASE no encontrado"
echo     exit 1
echo fi
echo echo ""
echo echo "=== Verificando Shell ==="
echo echo "Shell actual: $SHELL"
echo if [[ "$SHELL" == *"bash"* ]] ^|^| [[ "$SHELL" == *"ksh"* ]]; then
echo     echo "[OK] Shell compatible detectado"
echo else
echo     echo "[ADVERTENCIA] Shell: $SHELL (puede no ser compatible)"
echo fi
echo echo ""
echo echo "=== Verificando tmux ==="
echo if command -v tmux ^&^> /dev/null; then
echo     TMUX_VERSION=$(tmux -V)
echo     echo "[OK] tmux esta instalado: $TMUX_VERSION"
echo     TMUX_INSTALLED=1
echo else
echo     echo "[ERROR] tmux NO esta instalado"
echo     TMUX_INSTALLED=0
echo fi
echo echo ""
echo echo "=== Verificando yum ==="
echo if command -v yum ^&^> /dev/null; then
echo     echo "[OK] yum esta disponible"
echo     YUM_AVAILABLE=1
echo else
echo     echo "[ERROR] yum NO esta disponible"
echo     YUM_AVAILABLE=0
echo fi
echo echo ""
echo echo "=== Verificando PATH ==="
echo echo "PATH actual: $PATH"
echo if [[ "$PATH" == *"/QOpenSys/pkgs/bin"* ]]; then
echo     echo "[OK] /QOpenSys/pkgs/bin esta en el PATH"
echo else
echo     echo "[ADVERTENCIA] /QOpenSys/pkgs/bin NO esta en el PATH"
echo fi
echo echo ""
echo echo "=== Verificando permisos ==="
echo if [ -w "$HOME" ]; then
echo     echo "[OK] Tienes permisos de escritura en tu HOME: $HOME"
echo else
echo     echo "[ERROR] NO tienes permisos de escritura en tu HOME"
echo fi
echo echo ""
echo echo "=== Resumen ==="
echo if [ $TMUX_INSTALLED -eq 1 ]; then
echo     echo "Estado: tmux esta INSTALADO y listo para usar"
echo     exit 0
echo else
echo     if [ $YUM_AVAILABLE -eq 1 ]; then
echo         echo "Estado: tmux NO esta instalado, pero puede instalarse con yum"
echo         exit 2
echo     else
echo         echo "Estado: tmux NO esta instalado y yum no esta disponible"
echo         exit 3
echo     fi
echo fi
) > "%TEMP_SCRIPT%"

REM Ejecutar script en el IBM i
ssh -o ConnectTimeout=10 -o StrictHostKeyChecking=no %IBM_USER%@%IBM_HOST% "bash -s" < "%TEMP_SCRIPT%"

set SSH_EXIT_CODE=%errorlevel%

REM Limpiar archivo temporal
del "%TEMP_SCRIPT%" >nul 2>&1

echo.
echo ============================================
echo RESULTADO DE LA VALIDACION
echo ============================================
echo.

if %SSH_EXIT_CODE% equ 0 (
    echo [EXITO] tmux esta instalado y funcionando
    echo.
    echo Proximos pasos:
    echo 1. Conectarte por SSH: ssh %IBM_USER%@%IBM_HOST%
    echo 2. Iniciar tmux: tmux
    echo 3. O crear sesion con nombre: tmux new -s mi_sesion
) else if %SSH_EXIT_CODE% equ 2 (
    echo [ADVERTENCIA] tmux NO esta instalado, pero puede instalarse
    echo.
    echo Para instalar tmux:
    echo 1. Conectarte por SSH: ssh %IBM_USER%@%IBM_HOST%
    echo 2. Ejecutar: yum install tmux
    echo 3. Verificar: tmux -V
) else if %SSH_EXIT_CODE% equ 3 (
    echo [ERROR] tmux NO esta instalado y yum no esta disponible
    echo.
    echo Necesitas:
    echo 1. Instalar el gestor de paquetes yum en IBM i
    echo 2. O instalar tmux manualmente desde RPM
    echo 3. Contactar al administrador del sistema
) else if %SSH_EXIT_CODE% equ 255 (
    echo [ERROR] No se pudo conectar por SSH
    echo.
    echo Posibles causas:
    echo 1. Contrasena incorrecta
    echo 2. Usuario no tiene acceso SSH
    echo 3. SSH no esta habilitado en el IBM i
    echo 4. Firewall bloqueando el puerto 22
) else (
    echo [ERROR] Error desconocido (codigo: %SSH_EXIT_CODE%^)
)

echo.
echo ============================================
echo Validacion completada
echo ============================================
echo.

pause
exit /b %SSH_EXIT_CODE%