@echo off
REM ============================================
REM Script para ejecutar monitor-ibmi.sh desde Windows
REM ============================================

echo.
echo ========================================
echo   Ejecutando Monitor IBM i
echo ========================================
echo.
echo IP: 192.168.50.225
echo Usuario: EAMARCO
echo.

REM Primero copiar el script al IBM i
echo [1/3] Copiando script al IBM i...
scp "%~dp0monitor-ibmi.sh" EAMARCO@192.168.50.225:/home/EAMARCO/

if %ERRORLEVEL% NEQ 0 (
    echo ERROR: No se pudo copiar el script
    pause
    exit /b 1
)

echo.
echo [2/3] Dando permisos de ejecucion...
ssh EAMARCO@192.168.50.225 "chmod +x /home/EAMARCO/monitor-ibmi.sh"

echo.
echo [3/3] Ejecutando monitor...
echo.
echo IMPORTANTE: Estas entrando a tmux en el IBM i
echo Para salir: Ctrl+b d (desconectar) o 'exit' en cada panel
echo.
pause

REM Conectar y ejecutar el script
ssh -t EAMARCO@192.168.50.225 "/home/EAMARCO/monitor-ibmi.sh"

echo.
echo Sesion finalizada.
pause