# Guía de tmux para IBM i

## 📋 Índice
1. [Introducción](#introducción)
2. [Requisitos previos](#requisitos-previos)
3. [Instalación en IBM i](#instalación-en-ibm-i)
4. [Configuración básica](#configuración-básica)
5. [Comandos esenciales](#comandos-esenciales)
6. [Casos de uso en IBM i](#casos-de-uso-en-ibm-i)
7. [Solución de problemas](#solución-de-problemas)

---

## Introducción

**tmux** (Terminal Multiplexer) es una herramienta que permite gestionar múltiples sesiones de terminal en una sola ventana. En el contexto de IBM i, tmux funciona exclusivamente en el entorno **PASE** (Portable Application Solutions Environment).

### ¿Por qué usar tmux en IBM i?

- ✅ Mantener sesiones activas después de desconectarse
- ✅ Ejecutar procesos largos sin preocuparse por desconexiones
- ✅ Dividir la pantalla para monitorear múltiples procesos
- ✅ Gestionar múltiples tareas simultáneamente
- ✅ Ideal para administración remota de sistemas IBM i

---

## Requisitos previos

### Entorno necesario

1. **Acceso SSH al IBM i**
   - Puerto SSH habilitado (generalmente 22)
   - Usuario con permisos adecuados

2. **PASE (Portable Application Solutions Environment)**
   - Debe estar instalado y configurado
   - Acceso al shell bash o ksh

3. **Gestor de paquetes**
   - `yum` o `rpm` disponible
   - Conexión a repositorios de paquetes

### Verificar el entorno

```bash
# Conectar por SSH
ssh usuario@tu_ibmi_host

# Verificar que estás en PASE
echo $SHELL
# Salida esperada: /QOpenSys/pkgs/bin/bash

# Verificar versión de PASE
uname -a

# Verificar yum
yum --version
```

---

## Instalación en IBM i

### Método 1: Usando yum (Recomendado)

```bash
# Actualizar repositorios
yum update

# Instalar tmux
yum install tmux

# Verificar instalación
tmux -V
```

### Método 2: Usando rpm

```bash
# Descargar el paquete RPM
# (desde un repositorio confiable para IBM i PASE)

# Instalar
rpm -ivh tmux-*.rpm

# Verificar dependencias
rpm -qa | grep tmux
```

### Método 3: Compilar desde fuente (Avanzado)

```bash
# Instalar dependencias
yum install gcc make libevent-devel ncurses-devel

# Descargar tmux
wget https://github.com/tmux/tmux/releases/download/3.3a/tmux-3.3a.tar.gz

# Compilar
tar -xzf tmux-3.3a.tar.gz
cd tmux-3.3a
./configure
make
make install
```

---

## Configuración básica

### Crear archivo de configuración

```bash
# Crear archivo .tmux.conf en el home
cat > ~/.tmux.conf << 'EOF'
# Cambiar prefijo de Ctrl+b a Ctrl+a (opcional)
# set -g prefix C-a
# unbind C-b
# bind C-a send-prefix

# Habilitar mouse
set -g mouse on

# Mejorar colores
set -g default-terminal "screen-256color"

# Aumentar historial
set -g history-limit 10000

# Numeración de ventanas desde 1
set -g base-index 1
setw -g pane-base-index 1

# Renumerar ventanas automáticamente
set -g renumber-windows on

# Mostrar actividad en otras ventanas
setw -g monitor-activity on
set -g visual-activity on

# Dividir paneles con | y -
bind | split-window -h
bind - split-window -v
unbind '"'
unbind %

# Recargar configuración
bind r source-file ~/.tmux.conf \; display "Configuración recargada!"

# Navegación entre paneles estilo vim
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R
EOF

# Aplicar configuración
tmux source-file ~/.tmux.conf
```

---

## Comandos esenciales

### Gestión de sesiones

```bash
# Crear nueva sesión
tmux new -s nombre_sesion

# Crear sesión con nombre y comando
tmux new -s db2_monitor -d "db2 list applications"

# Listar sesiones activas
tmux ls

# Conectar a sesión existente
tmux attach -t nombre_sesion
tmux a -t nombre_sesion

# Desconectar de sesión (dentro de tmux)
Ctrl+b d

# Matar sesión
tmux kill-session -t nombre_sesion

# Matar todas las sesiones
tmux kill-server
```

### Gestión de ventanas

```bash
# Dentro de tmux:
Ctrl+b c        # Crear nueva ventana
Ctrl+b ,        # Renombrar ventana actual
Ctrl+b n        # Siguiente ventana
Ctrl+b p        # Ventana anterior
Ctrl+b 0-9      # Ir a ventana específica
Ctrl+b w        # Listar ventanas
Ctrl+b &        # Cerrar ventana actual
```

### Gestión de paneles

```bash
# Dentro de tmux:
Ctrl+b %        # Dividir verticalmente
Ctrl+b "        # Dividir horizontalmente
Ctrl+b o        # Cambiar al siguiente panel
Ctrl+b ;        # Cambiar al panel anterior
Ctrl+b x        # Cerrar panel actual
Ctrl+b z        # Zoom en panel actual (toggle)
Ctrl+b {        # Mover panel a la izquierda
Ctrl+b }        # Mover panel a la derecha
Ctrl+b Espacio  # Cambiar layout de paneles
Ctrl+b q        # Mostrar números de paneles
```

### Modo copia (scroll)

```bash
Ctrl+b [        # Entrar en modo copia
q               # Salir del modo copia
Espacio         # Iniciar selección
Enter           # Copiar selección
Ctrl+b ]        # Pegar
```

---

## Casos de uso en IBM i

### 1. Monitoreo de trabajos DB2

```bash
# Crear sesión de monitoreo
tmux new -s db2_monitor

# Panel 1: Monitorear aplicaciones activas
db2 list applications show detail

# Dividir panel (Ctrl+b ")
# Panel 2: Monitorear tablespaces
watch -n 5 'db2 list tablespaces show detail'

# Dividir panel (Ctrl+b %)
# Panel 3: Ver logs
tail -f /QIBM/UserData/OS400/DB2/logs/db2diag.log
```

### 2. Compilación y testing

```bash
# Sesión para desarrollo
tmux new -s desarrollo

# Ventana 1: Editor
vim mi_programa.rpgle

# Nueva ventana (Ctrl+b c)
# Ventana 2: Compilación
CRTBNDRPG PGM(MILIB/MIPGM) SRCFILE(MILIB/QRPGLESRC)

# Nueva ventana (Ctrl+b c)
# Ventana 3: Testing
CALL MILIB/MIPGM
```

### 3. Administración del sistema

```bash
# Sesión de administración
tmux new -s sysadmin

# Panel superior: Monitoreo de CPU/Memoria
top

# Panel inferior izquierdo: Logs del sistema
tail -f /QIBM/UserData/OS400/logs/system.log

# Panel inferior derecho: Trabajos activos
watch -n 10 'system "WRKACTJOB"'
```

### 4. Backup y restauración

```bash
# Sesión para backup
tmux new -s backup

# Ejecutar backup largo
savlib lib(MILIB) dev('/backup/milib.savf')

# Desconectar (Ctrl+b d)
# El backup continúa ejecutándose

# Reconectar más tarde
tmux attach -t backup
```

### 5. Scripts de mantenimiento

```bash
# Crear sesión para mantenimiento nocturno
tmux new -s mantenimiento -d

# Enviar comandos a la sesión
tmux send-keys -t mantenimiento "cd /scripts" C-m
tmux send-keys -t mantenimiento "./mantenimiento_nocturno.sh" C-m

# Verificar progreso
tmux attach -t mantenimiento
```

---

## Solución de problemas

### Problema: tmux no se encuentra

```bash
# Verificar instalación
which tmux

# Si no está instalado
yum install tmux

# Verificar PATH
echo $PATH
```

### Problema: Error de terminal

```bash
# Configurar TERM
export TERM=xterm-256color

# Agregar a .bashrc
echo 'export TERM=xterm-256color' >> ~/.bashrc
```

### Problema: Sesión no responde

```bash
# Listar sesiones
tmux ls

# Matar sesión problemática
tmux kill-session -t nombre_sesion

# Si todo falla, matar servidor tmux
tmux kill-server
```

### Problema: Permisos insuficientes

```bash
# Verificar permisos del socket
ls -la /tmp/tmux-*

# Limpiar sockets antiguos
rm -rf /tmp/tmux-*
```

### Problema: Configuración no se aplica

```bash
# Recargar configuración dentro de tmux
Ctrl+b :
source-file ~/.tmux.conf

# O desde línea de comandos
tmux source-file ~/.tmux.conf
```

---

## Scripts útiles

### Script de inicio automático

Crear `~/bin/tmux-start.sh`:

```bash
#!/bin/bash

# Verificar si la sesión existe
tmux has-session -t trabajo 2>/dev/null

if [ $? != 0 ]; then
    # Crear nueva sesión
    tmux new-session -d -s trabajo
    
    # Ventana 1: Monitoreo
    tmux rename-window -t trabajo:1 'Monitor'
    tmux send-keys -t trabajo:1 'top' C-m
    
    # Ventana 2: Logs
    tmux new-window -t trabajo:2 -n 'Logs'
    tmux send-keys -t trabajo:2 'tail -f /var/log/messages' C-m
    
    # Ventana 3: Trabajo
    tmux new-window -t trabajo:3 -n 'Work'
fi

# Conectar a la sesión
tmux attach-session -t trabajo
```

### Script de backup de sesiones

```bash
#!/bin/bash
# Guardar layout de sesiones
tmux list-sessions > ~/tmux-sessions-backup.txt
tmux list-windows -a >> ~/tmux-sessions-backup.txt
```

---

## Recursos adicionales

- [Documentación oficial de tmux](https://github.com/tmux/tmux/wiki)
- [IBM i Open Source](https://www.ibm.com/support/pages/node/706903)
- [Cheat Sheet de tmux](https://tmuxcheatsheet.com/)

---

## Notas importantes para IBM i

⚠️ **Limitaciones:**
- tmux NO funciona en sesiones 5250 tradicionales
- Solo disponible en PASE a través de SSH
- No compatible con QSH (QSHELL nativo)
- Requiere permisos adecuados para instalación

✅ **Ventajas:**
- Ideal para administración remota
- Perfecto para procesos largos
- Excelente para monitoreo continuo
- Aumenta productividad en tareas múltiples

---

**Última actualización:** 2026-01-01
**Versión:** 1.0