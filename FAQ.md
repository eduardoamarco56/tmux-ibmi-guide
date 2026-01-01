# Preguntas Frecuentes (FAQ) - tmux en IBM i

## 📌 Índice
1. [Instalación y Configuración](#instalación-y-configuración)
2. [Uso Básico](#uso-básico)
3. [Problemas Comunes](#problemas-comunes)
4. [Rendimiento](#rendimiento)
5. [Integración con IBM i](#integración-con-ibm-i)
6. [Avanzado](#avanzado)

---

## Instalación y Configuración

### ❓ ¿Puedo usar tmux en sesiones 5250?
**No.** tmux solo funciona en el entorno PASE a través de SSH. Las sesiones 5250 tradicionales (pantallas verdes) no son compatibles con tmux.

**Alternativas para 5250:**
- Usar múltiples sesiones 5250
- IBM Navigator for i (interfaz web)
- ACS (Access Client Solutions) con múltiples ventanas

---

### ❓ ¿Cómo instalo tmux en IBM i?
```bash
# Método 1: Usando yum (recomendado)
yum install tmux

# Método 2: Usando rpm
rpm -ivh tmux-*.rpm

# Verificar instalación
tmux -V
```

**Requisitos previos:**
- Acceso SSH al IBM i
- Entorno PASE configurado
- Permisos para instalar paquetes

---

### ❓ ¿Dónde está el archivo de configuración?
El archivo de configuración es `~/.tmux.conf` en tu directorio home de PASE.

```bash
# Crear archivo de configuración
vim ~/.tmux.conf

# O copiar ejemplo
cp /ruta/tmux.conf.ejemplo ~/.tmux.conf

# Recargar configuración (dentro de tmux)
Ctrl+b :source-file ~/.tmux.conf
```

---

### ❓ ¿Cómo cambio el prefijo de Ctrl+b?
Muchos usuarios prefieren `Ctrl+a` porque es más cómodo:

```bash
# Agregar a ~/.tmux.conf
set -g prefix C-a
unbind C-b
bind C-a send-prefix
```

---

## Uso Básico

### ❓ ¿Cómo salgo de tmux sin cerrar la sesión?
Usa `Ctrl+b d` para **desconectar** (detach). La sesión seguirá ejecutándose en segundo plano.

```bash
# Desconectar
Ctrl+b d

# Reconectar más tarde
tmux attach -t nombre_sesion
```

---

### ❓ ¿Cómo veo todas mis sesiones activas?
```bash
# Desde fuera de tmux
tmux ls

# Desde dentro de tmux
Ctrl+b s
```

---

### ❓ ¿Cómo cierro una sesión completamente?
```bash
# Método 1: Desde dentro de la sesión
exit  # En cada panel/ventana

# Método 2: Desde fuera
tmux kill-session -t nombre_sesion

# Método 3: Cerrar todas las sesiones
tmux kill-server
```

---

### ❓ ¿Cómo divido la pantalla?
```bash
# Dividir verticalmente (lado a lado)
Ctrl+b %

# Dividir horizontalmente (arriba/abajo)
Ctrl+b "

# Navegar entre paneles
Ctrl+b o  # Siguiente panel
Ctrl+b ;  # Panel anterior
```

---

### ❓ ¿Cómo hago scroll en tmux?
```bash
# Entrar en modo copia
Ctrl+b [

# Navegar con flechas o:
# - Page Up/Down
# - Ctrl+u / Ctrl+d (media página)
# - g / G (inicio/fin)

# Salir del modo copia
q
```

---

## Problemas Comunes

### ❓ Error: "command not found: tmux"
**Causa:** tmux no está instalado o no está en el PATH.

**Solución:**
```bash
# Verificar si está instalado
which tmux

# Si no está, instalar
yum install tmux

# Verificar PATH
echo $PATH

# Agregar al PATH si es necesario
export PATH=$PATH:/QOpenSys/pkgs/bin
```

---

### ❓ Los colores se ven mal
**Causa:** Terminal no soporta 256 colores.

**Solución:**
```bash
# Agregar a ~/.tmux.conf
set -g default-terminal "screen-256color"

# O en tu .bashrc
export TERM=xterm-256color

# Verificar soporte de colores
echo $TERM
```

---

### ❓ El mouse no funciona
**Causa:** Soporte de mouse no está habilitado.

**Solución:**
```bash
# Agregar a ~/.tmux.conf
set -g mouse on

# Recargar configuración
Ctrl+b :source-file ~/.tmux.conf
```

---

### ❓ "sessions should be nested with care"
**Causa:** Estás intentando iniciar tmux dentro de otra sesión tmux.

**Solución:**
```bash
# Salir de la sesión actual primero
exit

# O desconectar
Ctrl+b d

# Luego crear nueva sesión
tmux new -s nueva_sesion
```

---

### ❓ Panel no responde
**Solución:**
```bash
# Método 1: Respawn del panel
Ctrl+b :respawn-pane

# Método 2: Respawn forzado
Ctrl+b :respawn-pane -k

# Método 3: Cerrar y crear nuevo
Ctrl+b x  # Cerrar
Ctrl+b %  # Crear nuevo
```

---

### ❓ Sesión se congela al desconectar SSH
**Causa:** Configuración de SSH o red.

**Solución:**
```bash
# En tu cliente SSH, agregar a ~/.ssh/config
Host ibmi_host
    ServerAliveInterval 60
    ServerAliveCountMax 3

# O usar mosh en lugar de SSH (si está disponible)
mosh usuario@ibmi_host
```

---

## Rendimiento

### ❓ ¿tmux consume muchos recursos?
**No.** tmux es muy ligero. Consume aproximadamente:
- **Memoria:** 2-5 MB por sesión
- **CPU:** Mínimo (< 1% en reposo)

---

### ❓ ¿Cuántas sesiones puedo tener?
No hay límite práctico. Puedes tener:
- Múltiples sesiones (10+)
- Múltiples ventanas por sesión (20+)
- Múltiples paneles por ventana (10+)

**Recomendación:** Mantén solo las sesiones que necesites activas.

---

### ❓ ¿Afecta el rendimiento de mis programas?
**No.** tmux solo gestiona la interfaz de terminal. Tus programas corren con el mismo rendimiento.

---

## Integración con IBM i

### ❓ ¿Puedo ejecutar comandos CL en tmux?
**Sí**, usando el comando `system`:

```bash
# Ejecutar comando CL
system "WRKACTJOB"

# Ejecutar programa
system "CALL MYLIB/MYPGM"

# Ver biblioteca
system "DSPLIB MYLIB"
```

---

### ❓ ¿Puedo usar DB2 en tmux?
**Sí**, completamente:

```bash
# Iniciar DB2
db2

# O ejecutar comandos directamente
db2 "SELECT * FROM MYTABLE"

# Monitorear aplicaciones
watch -n 10 'db2 list applications show detail'
```

---

### ❓ ¿Cómo monitoreo trabajos activos?
```bash
# Opción 1: Comando system
watch -n 5 'system "WRKACTJOB"'

# Opción 2: Usar top (PASE)
top

# Opción 3: Script personalizado
watch -n 10 './monitor_jobs.sh'
```

---

### ❓ ¿Puedo compilar programas RPG/COBOL?
**Sí**, usando comandos CL:

```bash
# Compilar RPG
system "CRTBNDRPG PGM(MYLIB/MYPGM) SRCFILE(MYLIB/QRPGLESRC)"

# Compilar COBOL
system "CRTBNDCBL PGM(MYLIB/MYPGM) SRCFILE(MYLIB/QCBLLESRC)"

# Ver mensajes de compilación
system "DSPSPLF"
```

---

### ❓ ¿Funciona con IFS (Integrated File System)?
**Sí**, perfectamente:

```bash
# Navegar IFS
cd /home/usuario
ls -la

# Editar archivos
vim /home/usuario/script.sh

# Ejecutar scripts
./script.sh
```

---

## Avanzado

### ❓ ¿Cómo comparto una sesión con otro usuario?
```bash
# Usuario 1: Crear sesión compartida
tmux -S /tmp/shared new -s compartida
chmod 777 /tmp/shared

# Usuario 2: Conectarse
tmux -S /tmp/shared attach -t compartida

# Ambos usuarios verán lo mismo en tiempo real
```

---

### ❓ ¿Puedo automatizar la creación de sesiones?
**Sí**, con scripts:

```bash
#!/bin/bash
# Script: setup-workspace.sh

SESSION="trabajo"

# Crear sesión
tmux new-session -d -s $SESSION

# Ventana 1: Monitoreo
tmux rename-window -t $SESSION:1 'Monitor'
tmux send-keys -t $SESSION:1 'top' C-m

# Ventana 2: Logs
tmux new-window -t $SESSION:2 -n 'Logs'
tmux send-keys -t $SESSION:2 'tail -f /var/log/messages' C-m

# Ventana 3: Trabajo
tmux new-window -t $SESSION:3 -n 'Work'

# Conectar
tmux attach-session -t $SESSION
```

---

### ❓ ¿Cómo guardo el estado de mis sesiones?
Usa el plugin **tmux-resurrect**:

```bash
# Instalar TPM (Tmux Plugin Manager)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Agregar a ~/.tmux.conf
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-resurrect'

# Guardar sesión: Ctrl+b Ctrl+s
# Restaurar sesión: Ctrl+b Ctrl+r
```

---

### ❓ ¿Puedo usar tmux con scripts de automatización?
**Sí**, tmux es muy scripteable:

```bash
# Crear sesión y ejecutar comandos
tmux new -s auto -d
tmux send-keys -t auto 'cd /proyecto' C-m
tmux send-keys -t auto './build.sh' C-m

# Capturar output
tmux capture-pane -t auto -p > output.txt

# Enviar comandos a sesión existente
tmux send-keys -t auto 'ls -la' C-m
```

---

### ❓ ¿Cómo ejecuto comandos en múltiples paneles simultáneamente?
```bash
# Activar sincronización
Ctrl+b :setw synchronize-panes on

# Ahora todo lo que escribas se ejecuta en todos los paneles

# Desactivar
Ctrl+b :setw synchronize-panes off
```

---

### ❓ ¿Puedo cambiar el layout de paneles dinámicamente?
**Sí**:

```bash
# Ciclar entre layouts
Ctrl+b Espacio

# Layouts específicos:
Ctrl+b Alt+1  # Even horizontal
Ctrl+b Alt+2  # Even vertical
Ctrl+b Alt+3  # Main horizontal
Ctrl+b Alt+4  # Main vertical
Ctrl+b Alt+5  # Tiled
```

---

### ❓ ¿Cómo configuro tmux para que inicie automáticamente?
Agregar a tu `~/.bashrc`:

```bash
# Auto-iniciar tmux al conectar por SSH
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    # Intentar conectar a sesión existente o crear nueva
    tmux attach -t default || tmux new -s default
fi
```

---

### ❓ ¿Puedo usar tmux con vim/emacs?
**Sí**, funcionan perfectamente juntos:

```bash
# Vim en tmux
vim archivo.txt

# Emacs en tmux
emacs archivo.txt

# Tip: Cambiar prefijo de tmux si hay conflictos con atajos del editor
```

---

## 🆘 Ayuda Adicional

### ¿Dónde encuentro más ayuda?

```bash
# Man page
man tmux

# Ayuda interactiva (dentro de tmux)
Ctrl+b ?

# Listar todos los comandos
tmux list-commands

# Listar todos los atajos
tmux list-keys
```

### Recursos en línea
- [Documentación oficial](https://github.com/tmux/tmux/wiki)
- [tmux Cheat Sheet](https://tmuxcheatsheet.com/)
- [IBM i Open Source](https://www.ibm.com/support/pages/node/706903)

---

## 💬 ¿No encuentras tu pregunta?

Si tienes una pregunta que no está aquí:

1. Revisa la documentación oficial de tmux
2. Consulta el README.md de este repositorio
3. Usa `man tmux` para información detallada
4. Busca en foros de IBM i y comunidades de tmux

---

**Última actualización:** 2026-01-01  
**Versión:** 1.0 para IBM i PASE