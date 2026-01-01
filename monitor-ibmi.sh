#!/bin/bash
# ============================================
# Script de Monitoreo para IBM i (Corregido)
# ============================================

SESSION="monitor-ibmi"

# Verificar si la sesión ya existe
tmux has-session -t $SESSION 2>/dev/null

if [ $? != 0 ]; then
    # Crear sesión
    tmux new-session -d -s $SESSION -n "Sistema"
    
    # Panel 1: Procesos (en lugar de top)
    tmux send-keys -t $SESSION:1 'ps aux | head -30' C-m
    
    # Panel 2: Espacio en disco (sin -h)
    tmux split-window -h -t $SESSION:1
    tmux send-keys -t $SESSION:1.2 'df' C-m
    
    # Panel 3: Información del sistema
    tmux split-window -v -t $SESSION:1.2
    tmux send-keys -t $SESSION:1.3 'uname -a && echo "" && uptime' C-m
    
    # Ventana 2: Archivos y directorios
    tmux new-window -t $SESSION:2 -n "Files"
    tmux send-keys -t $SESSION:2 'ls -la' C-m
    
    # Ventana 3: Usuarios conectados
    tmux new-window -t $SESSION:3 -n "Users"
    tmux send-keys -t $SESSION:3 'who && echo "" && w' C-m
    
    # Volver a la primera ventana
    tmux select-window -t $SESSION:1
fi

# Conectar a la sesión
tmux attach-session -t $SESSION