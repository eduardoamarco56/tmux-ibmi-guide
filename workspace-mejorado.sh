#!/bin/bash
# ============================================
# Workspace Mejorado para IBM i
# ============================================
# Versión mejorada que maneja errores de permisos
# y usa comandos alternativos cuando es necesario
# ============================================

SESSION="workspace-pro"

# Verificar si la sesión ya existe
tmux has-session -t $SESSION 2>/dev/null
if [ $? = 0 ]; then
    echo "La sesión '$SESSION' ya existe. Conectando..."
    tmux attach-session -t $SESSION
    exit 0
fi

echo "Creando workspace profesional para IBM i..."
echo "Esto tomará unos 25 segundos..."

# Crear sesión
tmux new-session -d -s $SESSION -n "Dashboard"
sleep 1

# ============================================
# VENTANA 0: Dashboard (4 paneles)
# ============================================
echo "Configurando Dashboard..."

# Panel 0.0: Procesos principales
tmux send-keys -t $SESSION:0.0 'ps aux | head -25 && echo "" && echo "=== Procesos Principales ==="' C-m
sleep 1

# Dividir verticalmente - Panel 0.1
tmux split-window -h -t $SESSION:0.0
sleep 1
tmux send-keys -t $SESSION:0.1 'df 2>/dev/null || df -k && echo "" && echo "=== Espacio en Disco ==="' C-m
sleep 1

# Dividir panel 0.0 horizontalmente - Panel 0.2
tmux split-window -v -t $SESSION:0.0
sleep 1
tmux send-keys -t $SESSION:0.2 'echo "=== Información del Sistema ===" && echo "" && uname -a && echo "" && hostname && echo "" && date && echo "" && echo "Usuario: $USER" && echo "Home: $HOME"' C-m
sleep 1

# Dividir panel 0.1 horizontalmente - Panel 0.3
tmux split-window -v -t $SESSION:0.1
sleep 1
tmux send-keys -t $SESSION:0.3 'who 2>/dev/null && echo "" && echo "=== Usuarios Conectados ===" || echo "Usuarios conectados: $(who | wc -l)"' C-m
sleep 1

# ============================================
# VENTANA 1: Archivos y Sistema (3 paneles)
# ============================================
echo "Configurando Archivos..."

tmux new-window -t $SESSION:1 -n "Files"
sleep 1

# Panel 1.0: Directorio actual
tmux send-keys -t $SESSION:1.0 'echo "=== Directorio Actual ===" && echo "" && pwd && echo "" && ls -la | head -20' C-m
sleep 1

# Panel 1.1: Archivos recientes
tmux split-window -h -t $SESSION:1.0
sleep 1
tmux send-keys -t $SESSION:1.1 'echo "=== Archivos Recientes ===" && echo "" && ls -lt | head -15 2>/dev/null || ls -l | head -15' C-m
sleep 1

# Panel 1.2: Información de memoria
tmux split-window -v -t $SESSION:1.1
sleep 1
tmux send-keys -t $SESSION:1.2 'echo "=== Uso de Recursos ===" && echo "" && echo "Procesos del usuario:" && ps aux | grep $USER | wc -l && echo "" && echo "Archivos en home:" && ls -1 ~ | wc -l' C-m
sleep 1

# ============================================
# VENTANA 2: Monitoreo (3 paneles)
# ============================================
echo "Configurando Monitoreo..."

tmux new-window -t $SESSION:2 -n "Monitor"
sleep 1

# Panel 2.0: Procesos del usuario
tmux send-keys -t $SESSION:2.0 'echo "=== Mis Procesos ===" && echo "" && ps aux | grep $USER | head -20' C-m
sleep 1

# Panel 2.1: Variables de entorno importantes
tmux split-window -h -t $SESSION:2.0
sleep 1
tmux send-keys -t $SESSION:2.1 'echo "=== Variables de Entorno ===" && echo "" && echo "USER: $USER" && echo "HOME: $HOME" && echo "SHELL: $SHELL" && echo "PATH: $PATH" && echo "PWD: $PWD" && echo "HOSTNAME: $(hostname)"' C-m
sleep 1

# Panel 2.2: Conexiones de red
tmux split-window -v -t $SESSION:2.1
sleep 1
tmux send-keys -t $SESSION:2.2 'echo "=== Información de Red ===" && echo "" && hostname && echo "" && who | head -10' C-m
sleep 1

# ============================================
# VENTANA 3: DB2 y Comandos (2 paneles)
# ============================================
echo "Configurando DB2..."

tmux new-window -t $SESSION:3 -n "DB2"
sleep 1

# Panel 3.0: Comandos DB2
tmux send-keys -t $SESSION:3.0 'echo "=== Comandos DB2 Útiles ===" && echo "" && echo "db2 list applications show detail" && echo "db2 list tablespaces show detail" && echo "db2 list tables" && echo "db2 connect to database" && echo "" && echo "Para ejecutar, escribe el comando y presiona Enter"' C-m
sleep 1

# Panel 3.1: Comandos CL
tmux split-window -v -t $SESSION:3.0
sleep 1
tmux send-keys -t $SESSION:3.1 'echo "=== Comandos CL Útiles ===" && echo "" && echo "system \"WRKACTJOB\"" && echo "system \"DSPLIB MYLIB\"" && echo "system \"WRKSBS\"" && echo "system \"WRKUSRJOB\"" && echo "" && echo "Para ejecutar, escribe el comando y presiona Enter"' C-m
sleep 1

# ============================================
# VENTANA 4: Trabajo (panel único con ayuda)
# ============================================
echo "Configurando área de trabajo..."

tmux new-window -t $SESSION:4 -n "Work"
sleep 1
tmux send-keys -t $SESSION:4.0 'clear && echo "╔════════════════════════════════════════════════════════════╗" && echo "║          WORKSPACE PROFESIONAL PARA IBM i                  ║" && echo "╚════════════════════════════════════════════════════════════╝" && echo "" && echo "📊 VENTANAS DISPONIBLES:" && echo "  Ctrl+b 0  →  Dashboard    (4 paneles: procesos, disco, info, usuarios)" && echo "  Ctrl+b 1  →  Files        (3 paneles: actual, recientes, recursos)" && echo "  Ctrl+b 2  →  Monitor      (3 paneles: procesos, env, red)" && echo "  Ctrl+b 3  →  DB2          (2 paneles: comandos DB2 y CL)" && echo "  Ctrl+b 4  →  Work         (área de trabajo)" && echo "" && echo "🎯 NAVEGACIÓN:" && echo "  Ctrl+b o      →  Cambiar entre paneles" && echo "  Ctrl+b ;      →  Panel anterior" && echo "  Ctrl+b q      →  Mostrar números de paneles" && echo "  Ctrl+b z      →  Maximizar/restaurar panel" && echo "  Ctrl+b d      →  Desconectar (sesión sigue activa)" && echo "" && echo "📝 COMANDOS ÚTILES:" && echo "  ps aux        →  Ver procesos" && echo "  ls -la        →  Listar archivos" && echo "  df            →  Espacio en disco" && echo "  who           →  Usuarios conectados" && echo "  pwd           →  Directorio actual" && echo "" && echo "🔄 RECONECTAR:" && echo "  tmux attach -t workspace-pro" && echo "" && echo "═══════════════════════════════════════════════════════════" && echo "Listo para trabajar! 🚀"' C-m
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
echo "════════════════════════════════════════════════════════"
echo "  Workspace Profesional creado exitosamente!"
echo "════════════════════════════════════════════════════════"
echo ""
echo "📊 Estructura:"
echo "  Ventana 0 (Dashboard): 4 paneles - Vista general del sistema"
echo "  Ventana 1 (Files):     3 paneles - Gestión de archivos"
echo "  Ventana 2 (Monitor):   3 paneles - Monitoreo detallado"
echo "  Ventana 3 (DB2):       2 paneles - Comandos DB2 y CL"
echo "  Ventana 4 (Work):      1 panel  - Área de trabajo con ayuda"
echo ""
echo "🎯 Total: 5 ventanas, 13 paneles"
echo ""
echo "Conectando en 2 segundos..."
sleep 2

# Conectar a la sesión
tmux attach-session -t $SESSION