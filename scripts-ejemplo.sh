#!/bin/bash
# ============================================
# Scripts de ejemplo para tmux en IBM i
# ============================================
# Estos scripts facilitan el uso de tmux en IBM i
# Copiar a ~/bin/ y dar permisos de ejecución:
# chmod +x ~/bin/script_name.sh
# ============================================

# --------------------------------------------
# SCRIPT 1: Iniciar sesión de monitoreo
# --------------------------------------------
# Uso: tmux-monitor.sh
# Descripción: Crea una sesión con paneles para monitoreo del sistema

tmux_monitor() {
    SESSION="monitor-ibmi"
    
    # Verificar si la sesión ya existe
    tmux has-session -t $SESSION 2>/dev/null
    
    if [ $? != 0 ]; then
        # Crear sesión
        tmux new-session -d -s $SESSION -n "Sistema"
        
        # Panel principal: top
        tmux send-keys -t $SESSION:1 'top' C-m
        
        # Dividir horizontalmente para logs
        tmux split-window -h -t $SESSION:1
        tmux send-keys -t $SESSION:1.2 'tail -f /QIBM/UserData/OS400/logs/system.log' C-m
        
        # Dividir el panel derecho verticalmente
        tmux split-window -v -t $SESSION:1.2
        tmux send-keys -t $SESSION:1.3 'watch -n 5 "df -h"' C-m
        
        # Nueva ventana para DB2
        tmux new-window -t $SESSION:2 -n "DB2"
        tmux send-keys -t $SESSION:2 'watch -n 10 "db2 list applications show detail"' C-m
        
        # Nueva ventana para trabajos
        tmux new-window -t $SESSION:3 -n "Trabajos"
        tmux send-keys -t $SESSION:3 'watch -n 15 "system \"WRKACTJOB\""' C-m
        
        # Volver a la primera ventana
        tmux select-window -t $SESSION:1
    fi
    
    # Conectar a la sesión
    tmux attach-session -t $SESSION
}

# --------------------------------------------
# SCRIPT 2: Sesión de desarrollo
# --------------------------------------------
# Uso: tmux-dev.sh [nombre_proyecto]
# Descripción: Crea una sesión de desarrollo con editor, compilación y testing

tmux_dev() {
    PROJECT=${1:-"desarrollo"}
    SESSION="dev-$PROJECT"
    
    tmux has-session -t $SESSION 2>/dev/null
    
    if [ $? != 0 ]; then
        # Crear sesión
        tmux new-session -d -s $SESSION -n "Editor"
        
        # Ventana 1: Editor
        tmux send-keys -t $SESSION:1 'cd /home/proyecto' C-m
        tmux send-keys -t $SESSION:1 'vim .' C-m
        
        # Ventana 2: Compilación
        tmux new-window -t $SESSION:2 -n "Build"
        tmux send-keys -t $SESSION:2 'cd /home/proyecto' C-m
        
        # Ventana 3: Testing
        tmux new-window -t $SESSION:3 -n "Test"
        tmux send-keys -t $SESSION:3 'cd /home/proyecto' C-m
        
        # Ventana 4: Logs
        tmux new-window -t $SESSION:4 -n "Logs"
        tmux send-keys -t $SESSION:4 'tail -f /logs/app.log' C-m
        
        tmux select-window -t $SESSION:1
    fi
    
    tmux attach-session -t $SESSION
}

# --------------------------------------------
# SCRIPT 3: Backup con monitoreo
# --------------------------------------------
# Uso: tmux-backup.sh [biblioteca]
# Descripción: Ejecuta backup en tmux con monitoreo de progreso

tmux_backup() {
    LIBRARY=${1:-"MYLIB"}
    SESSION="backup-$LIBRARY"
    BACKUP_DIR="/backup"
    TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    
    tmux has-session -t $SESSION 2>/dev/null
    
    if [ $? != 0 ]; then
        # Crear sesión
        tmux new-session -d -s $SESSION -n "Backup"
        
        # Panel principal: Ejecutar backup
        tmux send-keys -t $SESSION:1 "echo 'Iniciando backup de $LIBRARY...'" C-m
        tmux send-keys -t $SESSION:1 "savlib lib($LIBRARY) dev('$BACKUP_DIR/${LIBRARY}_${TIMESTAMP}.savf')" C-m
        
        # Dividir para monitoreo
        tmux split-window -h -t $SESSION:1
        tmux send-keys -t $SESSION:1.2 "watch -n 5 'ls -lh $BACKUP_DIR | tail -10'" C-m
        
        # Panel inferior para logs
        tmux split-window -v -t $SESSION:1.1
        tmux send-keys -t $SESSION:1.3 "tail -f /QIBM/UserData/OS400/logs/backup.log" C-m
        
        echo "Sesión de backup creada: $SESSION"
        echo "Para conectar: tmux attach -t $SESSION"
        echo "Para desconectar sin detener: Ctrl+b d"
    else
        echo "La sesión $SESSION ya existe"
        tmux attach-session -t $SESSION
    fi
}

# --------------------------------------------
# SCRIPT 4: Sesión de administración
# --------------------------------------------
# Uso: tmux-admin.sh
# Descripción: Sesión completa para administración del sistema

tmux_admin() {
    SESSION="admin-ibmi"
    
    tmux has-session -t $SESSION 2>/dev/null
    
    if [ $? != 0 ]; then
        # Crear sesión
        tmux new-session -d -s $SESSION -n "Dashboard"
        
        # Layout de 4 paneles
        tmux send-keys -t $SESSION:1 'top' C-m
        tmux split-window -h -t $SESSION:1
        tmux send-keys -t $SESSION:1.2 'watch -n 5 "df -h"' C-m
        tmux split-window -v -t $SESSION:1.1
        tmux send-keys -t $SESSION:1.3 'watch -n 10 "netstat -an | grep ESTABLISHED | wc -l"' C-m
        tmux split-window -v -t $SESSION:1.2
        tmux send-keys -t $SESSION:1.4 'tail -f /var/log/messages' C-m
        
        # Ventana para comandos
        tmux new-window -t $SESSION:2 -n "Shell"
        
        # Ventana para DB2
        tmux new-window -t $SESSION:3 -n "DB2"
        tmux send-keys -t $SESSION:3 'db2' C-m
        
        tmux select-window -t $SESSION:1
    fi
    
    tmux attach-session -t $SESSION
}

# --------------------------------------------
# SCRIPT 5: Listar y gestionar sesiones
# --------------------------------------------
# Uso: tmux-list.sh
# Descripción: Muestra todas las sesiones activas con detalles

tmux_list() {
    echo "=========================================="
    echo "Sesiones activas de tmux"
    echo "=========================================="
    
    if tmux list-sessions 2>/dev/null; then
        echo ""
        echo "Comandos útiles:"
        echo "  tmux attach -t <nombre>  : Conectar a sesión"
        echo "  tmux kill-session -t <nombre> : Eliminar sesión"
        echo "  Ctrl+b d : Desconectar sin cerrar"
    else
        echo "No hay sesiones activas"
    fi
}

# --------------------------------------------
# SCRIPT 6: Limpiar sesiones antiguas
# --------------------------------------------
# Uso: tmux-clean.sh
# Descripción: Elimina sesiones que no tienen clientes conectados

tmux_clean() {
    echo "Limpiando sesiones sin clientes..."
    
    # Obtener lista de sesiones
    SESSIONS=$(tmux list-sessions -F "#{session_name}:#{session_attached}" 2>/dev/null)
    
    if [ -z "$SESSIONS" ]; then
        echo "No hay sesiones activas"
        return
    fi
    
    # Iterar sobre sesiones
    echo "$SESSIONS" | while IFS=: read -r session attached; do
        if [ "$attached" = "0" ]; then
            echo "Eliminando sesión sin clientes: $session"
            tmux kill-session -t "$session"
        else
            echo "Manteniendo sesión activa: $session"
        fi
    done
    
    echo "Limpieza completada"
}

# --------------------------------------------
# SCRIPT 7: Crear sesión personalizada
# --------------------------------------------
# Uso: tmux-custom.sh <nombre> <comando1> <comando2> ...
# Descripción: Crea una sesión con ventanas personalizadas

tmux_custom() {
    if [ $# -lt 2 ]; then
        echo "Uso: tmux-custom.sh <nombre_sesion> <comando1> [comando2] ..."
        return 1
    fi
    
    SESSION=$1
    shift
    
    tmux has-session -t $SESSION 2>/dev/null
    
    if [ $? = 0 ]; then
        echo "La sesión '$SESSION' ya existe"
        tmux attach-session -t $SESSION
        return
    fi
    
    # Crear sesión con primer comando
    tmux new-session -d -s $SESSION -n "Window1"
    tmux send-keys -t $SESSION:1 "$1" C-m
    shift
    
    # Crear ventanas adicionales
    WINDOW=2
    for cmd in "$@"; do
        tmux new-window -t $SESSION:$WINDOW -n "Window$WINDOW"
        tmux send-keys -t $SESSION:$WINDOW "$cmd" C-m
        WINDOW=$((WINDOW + 1))
    done
    
    tmux select-window -t $SESSION:1
    tmux attach-session -t $SESSION
}

# --------------------------------------------
# SCRIPT 8: Guardar layout de sesión
# --------------------------------------------
# Uso: tmux-save-layout.sh <nombre_sesion>
# Descripción: Guarda la configuración de una sesión

tmux_save_layout() {
    SESSION=${1:-$(tmux display-message -p '#S')}
    OUTPUT_FILE="$HOME/.tmux-layouts/$SESSION.layout"
    
    mkdir -p "$HOME/.tmux-layouts"
    
    echo "Guardando layout de sesión: $SESSION"
    
    # Guardar información de la sesión
    {
        echo "# Layout de sesión: $SESSION"
        echo "# Fecha: $(date)"
        echo ""
        tmux list-windows -t $SESSION -F "Window #{window_index}: #{window_name}"
        echo ""
        tmux list-panes -t $SESSION -F "Pane #{pane_index} en Window #{window_index}: #{pane_current_command}"
    } > "$OUTPUT_FILE"
    
    echo "Layout guardado en: $OUTPUT_FILE"
}

# --------------------------------------------
# MENÚ PRINCIPAL
# --------------------------------------------

show_menu() {
    echo "=========================================="
    echo "Scripts de tmux para IBM i"
    echo "=========================================="
    echo "1. Iniciar sesión de monitoreo"
    echo "2. Iniciar sesión de desarrollo"
    echo "3. Iniciar backup con monitoreo"
    echo "4. Iniciar sesión de administración"
    echo "5. Listar sesiones activas"
    echo "6. Limpiar sesiones antiguas"
    echo "7. Crear sesión personalizada"
    echo "8. Guardar layout de sesión"
    echo "9. Salir"
    echo "=========================================="
    read -p "Seleccione una opción: " option
    
    case $option in
        1) tmux_monitor ;;
        2) read -p "Nombre del proyecto: " proj; tmux_dev "$proj" ;;
        3) read -p "Nombre de la biblioteca: " lib; tmux_backup "$lib" ;;
        4) tmux_admin ;;
        5) tmux_list ;;
        6) tmux_clean ;;
        7) read -p "Nombre de sesión: " name; 
           read -p "Comandos (separados por espacio): " cmds;
           tmux_custom $name $cmds ;;
        8) read -p "Nombre de sesión: " sess; tmux_save_layout "$sess" ;;
        9) exit 0 ;;
        *) echo "Opción inválida" ;;
    esac
}

# Si el script se ejecuta directamente, mostrar menú
if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
    show_menu
fi