#!/bin/bash
# ============================================
# Script de 4 Ventanas TN5250 para IBM i (DEBUG)
# ============================================

echo "=== DEBUG: Inicio del script ==="
echo "LANG actual: $LANG"
echo "LC_ALL actual: $LC_ALL"
echo "LC_CTYPE actual: $LC_CTYPE"
echo ""

# Configurar locale
export LANG=C
export LC_ALL=C
export LC_CTYPE=C

echo "=== DEBUG: Después de configurar locale ==="
echo "LANG: $LANG"
echo "LC_ALL: $LC_ALL"
echo "LC_CTYPE: $LC_CTYPE"
echo ""

echo "=== DEBUG: Verificando tmux ==="
which tmux
tmux -V
echo ""

SESSION="tn5250-ibmi"
HOST="TU_IBM_i_HOST"

echo "=== DEBUG: Verificando si la sesión existe ==="
tmux has-session -t $SESSION 2>/dev/null
SESSION_EXISTS=$?
echo "Resultado: $SESSION_EXISTS (0=existe, 1=no existe)"
echo ""

if [ $SESSION_EXISTS != 0 ]; then
    echo "=== DEBUG: Creando nueva sesión ==="
    
    # Crear sesión con la primera ventana
    echo "Creando sesión $SESSION..."
    tmux new-session -d -s $SESSION -n "TN5250-1"
    
    if [ $? -eq 0 ]; then
        echo "✓ Sesión creada exitosamente"
        
        # Ventana 1: Primera sesión TN5250
        echo "Configurando ventana 1..."
        tmux send-keys -t $SESSION:1 "tn5250 $HOST" C-m
        
        # Ventana 2: Segunda sesión TN5250
        echo "Creando ventana 2..."
        tmux new-window -t $SESSION:2 -n "TN5250-2"
        tmux send-keys -t $SESSION:2 "tn5250 $HOST" C-m
        
        # Ventana 3: Tercera sesión TN5250
        echo "Creando ventana 3..."
        tmux new-window -t $SESSION:3 -n "TN5250-3"
        tmux send-keys -t $SESSION:3 "tn5250 $HOST" C-m
        
        # Ventana 4: Cuarta sesión TN5250
        echo "Creando ventana 4..."
        tmux new-window -t $SESSION:4 -n "TN5250-4"
        tmux send-keys -t $SESSION:4 "tn5250 $HOST" C-m
        
        # Volver a la primera ventana
        tmux select-window -t $SESSION:1
        
        echo "✓ Todas las ventanas creadas"
    else
        echo "✗ Error al crear la sesión"
        exit 1
    fi
else
    echo "=== DEBUG: La sesión ya existe ==="
fi

echo ""
echo "=== DEBUG: Conectando a la sesión ==="
# Conectar a la sesión
tmux attach-session -t $SESSION