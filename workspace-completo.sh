#!/bin/bash
# ============================================
# Workspace Completo para IBM i
# ============================================
# Crea un entorno de trabajo completo con:
# - 4 ventanas
# - Múltiples paneles
# - Comandos útiles para administración
# ============================================

SESSION="workspace-ibmi"

# Verificar si la sesión ya existe
tmux has-session -t $SESSION 2>/dev/null
if [ $? = 0 ]; then
    echo "La sesión '$SESSION' ya existe. Conectando..."
    tmux attach-session -t $SESSION
    exit 0
fi

echo "Creando workspace completo para IBM i..."
echo "Esto tomará unos 20 segundos..."

# Crear sesión
tmux new-session -d -s $SESSION -n "Dashboard"
sleep 1

# ============================================
# VENTANA 0: Dashboard (4 paneles)
# ============================================
echo "Configurando Dashboard..."

# Panel 0.0: Procesos principales
tmux send-keys -t $SESSION:0.0 'ps aux | head -25' C-m
sleep 1

# Dividir verticalmente - Panel 0.1
tmux split-window -h -t $SESSION:0.0
sleep 1
tmux send-keys -t $SESSION:0.1 'df && echo "" && echo "Espacio en disco"' C-m
sleep 1

# Dividir panel 0.0 horizontalmente - Panel 0.2
tmux split-window -v -t $SESSION:0.0
sleep 1
tmux send-keys -t $SESSION:0.2 'uname -a && echo "" && uptime && echo "" && hostname' C-m
sleep 1

# Dividir panel 0.1 horizontalmente - Panel 0.3
tmux split-window -v -t $SESSION:0.1
sleep 1
tmux send-keys -t $SESSION:0.3 'who && echo "" && echo "Usuarios conectados"' C-m
sleep 1

# ============================================
# VENTANA 1: Archivos y Directorios (3 paneles)
# ============================================
echo "Configurando Archivos..."

tmux new-window -t $SESSION:1 -n "Files"
sleep 1

# Panel 1.0: Directorio actual
tmux send-keys -t $SESSION:1.0 'ls -la && echo "" && pwd' C-m
sleep 1

# Panel 1.1: Directorio /tmp
tmux split-window -h -t $SESSION:1.0
sleep 1
tmux send-keys -t $SESSION:1.1 'ls -la /tmp | head -20 && echo "" && echo "Archivos temporales"' C-m
sleep 1

# Panel 1.2: Espacio detallado
tmux split-window -v -t $SESSION:1.1
sleep 1
tmux send-keys -t $SESSION:1.2 'df -k && echo "" && echo "Espacio detallado en KB"' C-m
sleep 1

# ============================================
# VENTANA 2: Logs y Monitoreo (2 paneles)
# ============================================
echo "Configurando Logs..."

tmux new-window -t $SESSION:2 -n "Logs"
sleep 1

# Panel 2.0: Últimas líneas de logs
tmux send-keys -t $SESSION:2.0 'ls -lt /var/log 2>/dev/null | head -15 || echo "Logs del sistema"' C-m
sleep 1

# Panel 2.1: Procesos del usuario
tmux split-window -v -t $SESSION:2.0
sleep 1
tmux send-keys -t $SESSION:2.1 'ps aux | grep $USER | head -20' C-m
sleep 1

# ============================================
# VENTANA 3: Trabajo (panel único)
# ============================================
echo "Configurando área de trabajo..."

tmux new-window -t $SESSION:3 -n "Work"
sleep 1
tmux send-keys -t $SESSION:3.0 'echo "=== Área de Trabajo ===" && echo "" && echo "Comandos útiles:" && echo "  ls -la    : Listar archivos" && echo "  pwd       : Directorio actual" && echo "  df        : Espacio en disco" && echo "  ps aux    : Procesos" && echo "  who       : Usuarios" && echo "" && echo "Navegación tmux:" && echo "  Ctrl+b 0-3 : Cambiar ventana" && echo "  Ctrl+b o   : Cambiar panel" && echo "  Ctrl+b d   : Desconectar"' C-m
sleep 1

# ============================================
# Configuración final
# ============================================
echo "Finalizando configuración..."

# Volver a la primera ventana
tmux select-window -t $SESSION:0
sleep 1

# Seleccionar el primer panel
tmux select-pane -t $SESSION:0.0
sleep 1

echo ""
echo "============================================"
echo "Workspace creado exitosamente!"
echo "============================================"
echo ""
echo "Estructura:"
echo "  Ventana 0 (Dashboard): 4 paneles"
echo "  Ventana 1 (Files):     3 paneles"
echo "  Ventana 2 (Logs):      2 paneles"
echo "  Ventana 3 (Work):      1 panel"
echo ""
echo "Conectando..."
sleep 2

# Conectar a la sesión
tmux attach-session -t $SESSION