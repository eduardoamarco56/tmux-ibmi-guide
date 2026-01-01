# Cheat Sheet de tmux para IBM i

## 🚀 Inicio Rápido

```bash
# Conectar por SSH a IBM i
ssh usuario@ibmi_host

# Verificar que estás en PASE
echo $SHELL  # Debe mostrar /QOpenSys/pkgs/bin/bash

# Iniciar tmux
tmux

# O crear sesión con nombre
tmux new -s mi_sesion
```

---

## 📋 Gestión de Sesiones

| Comando | Descripción |
|---------|-------------|
| `tmux` | Iniciar nueva sesión |
| `tmux new -s nombre` | Nueva sesión con nombre |
| `tmux ls` | Listar sesiones activas |
| `tmux attach -t nombre` | Conectar a sesión |
| `tmux a -t nombre` | Conectar (forma corta) |
| `tmux kill-session -t nombre` | Eliminar sesión |
| `tmux kill-server` | Eliminar todas las sesiones |
| `Ctrl+b d` | Desconectar de sesión |
| `Ctrl+b $` | Renombrar sesión actual |
| `Ctrl+b s` | Listar y cambiar sesiones |

---

## 🪟 Gestión de Ventanas

| Atajo | Descripción |
|-------|-------------|
| `Ctrl+b c` | Crear nueva ventana |
| `Ctrl+b ,` | Renombrar ventana |
| `Ctrl+b n` | Siguiente ventana |
| `Ctrl+b p` | Ventana anterior |
| `Ctrl+b 0-9` | Ir a ventana específica |
| `Ctrl+b w` | Listar ventanas |
| `Ctrl+b &` | Cerrar ventana (confirmar) |
| `Ctrl+b f` | Buscar ventana por nombre |
| `Ctrl+b l` | Última ventana usada |

---

## 📱 Gestión de Paneles

### Crear Paneles

| Atajo | Descripción |
|-------|-------------|
| `Ctrl+b %` | Dividir verticalmente |
| `Ctrl+b "` | Dividir horizontalmente |
| `Ctrl+b x` | Cerrar panel (confirmar) |

### Navegar entre Paneles

| Atajo | Descripción |
|-------|-------------|
| `Ctrl+b o` | Siguiente panel |
| `Ctrl+b ;` | Panel anterior |
| `Ctrl+b q` | Mostrar números de paneles |
| `Ctrl+b q 0-9` | Ir a panel específico |
| `Ctrl+b {` | Mover panel a la izquierda |
| `Ctrl+b }` | Mover panel a la derecha |
| `Ctrl+b Ctrl+o` | Rotar paneles |

### Redimensionar Paneles

| Atajo | Descripción |
|-------|-------------|
| `Ctrl+b :resize-pane -L 5` | Reducir ancho (izquierda) |
| `Ctrl+b :resize-pane -R 5` | Aumentar ancho (derecha) |
| `Ctrl+b :resize-pane -U 5` | Reducir altura (arriba) |
| `Ctrl+b :resize-pane -D 5` | Aumentar altura (abajo) |
| `Ctrl+b z` | Maximizar/restaurar panel |
| `Ctrl+b Espacio` | Cambiar layout automático |

---

## 📜 Modo Copia y Scroll

| Atajo | Descripción |
|-------|-------------|
| `Ctrl+b [` | Entrar en modo copia |
| `q` | Salir del modo copia |
| `Espacio` | Iniciar selección |
| `Enter` | Copiar selección |
| `Ctrl+b ]` | Pegar |
| `/` | Buscar hacia adelante |
| `?` | Buscar hacia atrás |
| `n` | Siguiente resultado |
| `N` | Resultado anterior |

---

## ⚙️ Comandos de Configuración

| Comando | Descripción |
|---------|-------------|
| `Ctrl+b :` | Entrar en modo comando |
| `Ctrl+b ?` | Mostrar todos los atajos |
| `Ctrl+b t` | Mostrar reloj |
| `Ctrl+b r` | Recargar configuración (si está configurado) |

---

## 🔧 Comandos Útiles en Línea

```bash
# Crear sesión y ejecutar comando
tmux new -s backup -d "savlib lib(MYLIB) dev('/backup/mylib.savf')"

# Enviar comando a sesión existente
tmux send-keys -t backup "ls -la" C-m

# Capturar contenido de panel
tmux capture-pane -t backup -p > output.txt

# Listar todas las ventanas de todas las sesiones
tmux list-windows -a

# Listar todos los paneles
tmux list-panes -a

# Matar todas las sesiones excepto una
tmux kill-session -a -t mi_sesion
```

---

## 💡 Casos de Uso Comunes en IBM i

### 1. Monitoreo de Sistema

```bash
# Crear sesión de monitoreo
tmux new -s monitor

# Panel 1: CPU y memoria
top

# Dividir (Ctrl+b ")
# Panel 2: Espacio en disco
watch -n 5 'df -h'

# Dividir (Ctrl+b %)
# Panel 3: Logs del sistema
tail -f /var/log/messages
```

### 2. Backup Largo

```bash
# Iniciar backup en tmux
tmux new -s backup
savlib lib(BIGLIB) dev('/backup/biglib.savf')

# Desconectar (Ctrl+b d)
# El backup continúa ejecutándose

# Reconectar más tarde
tmux attach -t backup
```

### 3. Desarrollo

```bash
# Sesión de desarrollo
tmux new -s dev

# Ventana 1: Editor
vim programa.rpgle

# Nueva ventana (Ctrl+b c)
# Ventana 2: Compilación
CRTBNDRPG PGM(MYLIB/MYPGM) SRCFILE(MYLIB/QRPGLESRC)

# Nueva ventana (Ctrl+b c)
# Ventana 3: Testing
CALL MYLIB/MYPGM
```

### 4. Monitoreo de DB2

```bash
tmux new -s db2

# Panel superior: Aplicaciones activas
watch -n 10 'db2 list applications show detail'

# Panel inferior (Ctrl+b "): Tablespaces
watch -n 30 'db2 list tablespaces show detail'
```

---

## 🎨 Layouts Predefinidos

| Atajo | Layout |
|-------|--------|
| `Ctrl+b Alt+1` | Even horizontal |
| `Ctrl+b Alt+2` | Even vertical |
| `Ctrl+b Alt+3` | Main horizontal |
| `Ctrl+b Alt+4` | Main vertical |
| `Ctrl+b Alt+5` | Tiled |

---

## 🔍 Búsqueda y Filtrado

```bash
# Dentro del modo copia (Ctrl+b [)
/texto          # Buscar "texto" hacia adelante
?texto          # Buscar "texto" hacia atrás
n               # Siguiente resultado
N               # Resultado anterior
```

---

## 🚨 Solución Rápida de Problemas

### Panel no responde
```bash
Ctrl+b :respawn-pane
```

### Limpiar historial
```bash
Ctrl+b :clear-history
```

### Resetear panel
```bash
Ctrl+b :respawn-pane -k
```

### Ver información de sesión
```bash
tmux info
```

---

## 📝 Sincronización de Paneles

```bash
# Activar sincronización (ejecutar comandos en todos los paneles)
Ctrl+b :setw synchronize-panes on

# Desactivar sincronización
Ctrl+b :setw synchronize-panes off

# Toggle (alternar)
Ctrl+b :setw synchronize-panes
```

---

## 🎯 Tips y Trucos

### 1. Crear sesión con múltiples ventanas
```bash
tmux new -s trabajo \; \
  new-window -n editor \; \
  new-window -n logs \; \
  new-window -n monitor \; \
  select-window -t 1
```

### 2. Guardar output de panel
```bash
# Capturar últimas 1000 líneas
tmux capture-pane -S -1000 -p > output.txt
```

### 3. Compartir sesión entre usuarios
```bash
# Usuario 1 crea sesión
tmux -S /tmp/shared new -s compartida

# Dar permisos
chmod 777 /tmp/shared

# Usuario 2 se conecta
tmux -S /tmp/shared attach -t compartida
```

### 4. Ejecutar comando en todas las ventanas
```bash
tmux list-windows -t sesion -F '#{window_index}' | \
  xargs -I {} tmux send-keys -t sesion:{} 'comando' C-m
```

### 5. Crear backup de sesión
```bash
# Guardar layout
tmux list-windows -t sesion > sesion-backup.txt
tmux list-panes -t sesion >> sesion-backup.txt
```

---

## 🔐 Seguridad

```bash
# Bloquear sesión
Ctrl+b :lock-session

# Bloquear cliente
Ctrl+b :lock-client

# Configurar contraseña (en .tmux.conf)
set -g lock-command "vlock"
```

---

## 📊 Información del Sistema

```bash
# Ver información de tmux
tmux info

# Ver variables de entorno
tmux show-environment

# Ver opciones de sesión
tmux show-options -g

# Ver opciones de ventana
tmux show-window-options -g
```

---

## 🎓 Recursos Adicionales

- **Documentación oficial**: https://github.com/tmux/tmux/wiki
- **Man page**: `man tmux`
- **Ayuda interactiva**: `Ctrl+b ?`
- **Modo comando**: `Ctrl+b :` luego escribe el comando

---

## ⚡ Atajos Personalizados Recomendados

Agregar a `~/.tmux.conf`:

```bash
# Recargar configuración
bind r source-file ~/.tmux.conf \; display "Recargado!"

# Dividir paneles más intuitivo
bind | split-window -h
bind - split-window -v

# Navegación estilo vim
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# Sincronizar paneles
bind S setw synchronize-panes
```

---

**Última actualización:** 2026-01-01  
**Versión:** 1.0 para IBM i PASE