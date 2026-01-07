#!/bin/bash
# ============================================
# Script de 4 Ventanas TN5250 para IBM i
# ============================================

# Forzar re-ejecución con bash y locale correcto si es necesario
if [ -z "$LOCALE_SET" ]; then
    export LOCALE_SET=1
    export LANG=C
    export LC_ALL=C
    export LC_CTYPE=C
    exec bash "$0" "$@"
fi

SESSION="tn5250-ibmi"
HOST="TU_IBM_i_HOST"

# Verificar si la sesión ya existe
tmux has-session -t $SESSION 2>/dev/null

if [ $? != 0 ]; then
    # Crear sesión con la primera ventana
    tmux new-session -d -s $SESSION -n "TN5250-1"
    
    # Ventana 1: Primera sesión TN5250
    tmux send-keys -t $SESSION:1 "tn5250 $HOST" C-m
    
    # Ventana 2: Segunda sesión TN5250
    tmux new-window -t $SESSION:2 -n "TN5250-2"
    tmux send-keys -t $SESSION:2 "tn5250 $HOST" C-m
    
    # Ventana 3: Tercera sesión TN5250
    tmux new-window -t $SESSION:3 -n "TN5250-3"
    tmux send-keys -t $SESSION:3 "tn5250 $HOST" C-m
    
    # Ventana 4: Cuarta sesión TN5250
    tmux new-window -t $SESSION:4 -n "TN5250-4"
    tmux send-keys -t $SESSION:4 "tn5250 $HOST" C-m
    
    # Volver a la primera ventana
    tmux select-window -t $SESSION:1
fi

# Conectar a la sesión
tmux attach-session -t $SESSION