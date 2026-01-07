#!/bin/bash
# ============================================
# Script de 4 Ventanas TN5250 usando SCREEN
# (Alternativa a tmux para IBM i)
# ============================================

SESSION="tn5250-ibmi"
HOST="TU_IBM_i_HOST"

# Verificar si screen está instalado
if ! command -v screen &> /dev/null; then
    echo "ERROR: screen no está instalado"
    echo "Instalar con: yum install screen"
    exit 1
fi

# Verificar si la sesión ya existe
screen -list | grep -q "$SESSION"

if [ $? != 0 ]; then
    echo "Creando sesión con 4 ventanas TN5250..."
    
    # Crear sesión detached
    screen -dmS $SESSION
    
    # Ventana 0: Primera sesión TN5250
    screen -S $SESSION -X screen -t "TN5250-1" tn5250 $HOST
    
    # Ventana 1: Segunda sesión TN5250
    screen -S $SESSION -X screen -t "TN5250-2" tn5250 $HOST
    
    # Ventana 2: Tercera sesión TN5250
    screen -S $SESSION -X screen -t "TN5250-3" tn5250 $HOST
    
    # Ventana 3: Cuarta sesión TN5250
    screen -S $SESSION -X screen -t "TN5250-4" tn5250 $HOST
    
    echo "✓ Sesión creada con 4 ventanas"
    echo ""
    echo "Comandos útiles:"
    echo "  Ctrl+a 0-3  : Cambiar entre ventanas"
    echo "  Ctrl+a d    : Desconectar"
    echo "  Ctrl+a k    : Cerrar ventana actual"
    echo ""
fi

# Conectar a la sesión
screen -r $SESSION