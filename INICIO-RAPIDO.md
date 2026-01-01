# 🚀 Inicio Rápido - Ya estás en tmux!

¡Felicidades! Ya estás conectado a tmux en tu IBM i. Esta guía te ayudará a dar tus primeros pasos.

---

## 📍 Dónde Estás

Estás dentro de una sesión de tmux en tu IBM i:
- **Entorno:** IBM i PASE
- **Shell:** bash o ksh

---

## 🎯 Primeros 5 Comandos Esenciales

### 1. Dividir la Pantalla Verticalmente
```
Ctrl+b %
```
Esto creará dos paneles lado a lado. ¡Pruébalo ahora!

### 2. Dividir la Pantalla Horizontalmente
```
Ctrl+b "
```
Esto creará dos paneles arriba y abajo.

### 3. Cambiar entre Paneles
```
Ctrl+b o
```
Presiona varias veces para moverte entre paneles.

### 4. Desconectar (sin cerrar la sesión)
```
Ctrl+b d
```
Tu sesión seguirá activa. Puedes reconectar con: `tmux attach`

### 5. Ver Todos los Atajos
```
Ctrl+b ?
```
Presiona `q` para salir de la ayuda.

---

## 🧪 Ejercicio Práctico (5 minutos)

### Paso 1: Crear un Layout de Trabajo

```bash
# Ya estás en tmux, ahora:

# 1. Dividir verticalmente
Ctrl+b %

# 2. En el panel derecho, dividir horizontalmente
Ctrl+b "

# Ahora tienes 3 paneles:
# ┌─────────┬─────────┐
# │         │    2    │
# │    1    ├─────────┤
# │         │    3    │
# └─────────┴─────────┘
```

### Paso 2: Usar Cada Panel

```bash
# Panel 1 (izquierdo): Monitoreo del sistema
Ctrl+b o  # Ir al panel 1
top

# Panel 2 (superior derecho): Ver archivos
Ctrl+b o  # Ir al panel 2
ls -la
pwd

# Panel 3 (inferior derecho): Logs o comandos
Ctrl+b o  # Ir al panel 3
echo "Panel 3 listo para trabajar"
```

### Paso 3: Navegar entre Paneles

```bash
# Método 1: Ciclar entre paneles
Ctrl+b o

# Método 2: Ver números de paneles
Ctrl+b q
# Luego presiona el número del panel al que quieres ir
```

---

## 💡 Casos de Uso Inmediatos

### Caso 1: Monitorear el Sistema

```bash
# Panel 1: CPU y Memoria
top

# Panel 2: Espacio en disco
watch -n 5 'df -h'

# Panel 3: Procesos
ps aux | head -20
```

### Caso 2: Desarrollo y Testing

```bash
# Panel 1: Editor
vim mi_archivo.txt

# Panel 2: Compilación/Ejecución
# Aquí ejecutas tus comandos

# Panel 3: Logs
tail -f /logs/app.log
```

### Caso 3: Administración de DB2

```bash
# Panel 1: Consultas DB2
db2

# Panel 2: Monitoreo de aplicaciones
watch -n 10 'db2 list applications show detail'

# Panel 3: Logs de DB2
tail -f /QIBM/UserData/OS400/DB2/logs/db2diag.log
```

---

## 🎨 Crear Ventanas Adicionales

Además de paneles, puedes crear ventanas (como pestañas):

```bash
# Crear nueva ventana
Ctrl+b c

# Cambiar a siguiente ventana
Ctrl+b n

# Cambiar a ventana anterior
Ctrl+b p

# Ir a ventana específica (0-9)
Ctrl+b 0
Ctrl+b 1
# etc.

# Renombrar ventana actual
Ctrl+b ,
# Escribe el nuevo nombre y presiona Enter

# Listar todas las ventanas
Ctrl+b w
```

---

## 📜 Hacer Scroll (Ver Historial)

```bash
# Entrar en modo copia/scroll
Ctrl+b [

# Navegar:
# - Flechas arriba/abajo
# - Page Up / Page Down
# - Ctrl+u (media página arriba)
# - Ctrl+d (media página abajo)

# Salir del modo scroll
q
```

---

## 🔍 Buscar en el Historial

```bash
# Entrar en modo copia
Ctrl+b [

# Buscar hacia adelante
/texto_a_buscar
Enter

# Siguiente resultado
n

# Resultado anterior
N

# Salir
q
```

---

## 💾 Guardar tu Trabajo

### Opción 1: Desconectar (Recomendado)

```bash
# Desconectar sin cerrar
Ctrl+b d

# Tu sesión sigue activa
# Para reconectar más tarde:
tmux attach
# o
tmux attach -t nombre_sesion
```

### Opción 2: Cerrar Completamente

```bash
# En cada panel, escribe:
exit

# O cierra la ventana del terminal
```

---

## 🎯 Comandos Útiles para IBM i

### Ejecutar Comandos CL

```bash
# Desde tmux, puedes ejecutar comandos CL:
system "WRKACTJOB"
system "DSPLIB MYLIB"
system "CALL MYLIB/MYPGM"
```

### Trabajar con DB2

```bash
# Iniciar DB2
db2

# O ejecutar consultas directamente
db2 "SELECT * FROM MYTABLE FETCH FIRST 10 ROWS ONLY"

# Listar aplicaciones
db2 list applications show detail
```

### Monitorear Trabajos

```bash
# Ver trabajos activos
watch -n 5 'system "WRKACTJOB"'

# Ver subsistemas
system "WRKSBS"
```

---

## 🆘 Ayuda Rápida

### Si algo sale mal:

```bash
# Panel no responde
Ctrl+b :respawn-pane

# Limpiar pantalla
Ctrl+l

# Limpiar historial
Ctrl+b :clear-history

# Ver información de tmux
Ctrl+b :display-message "Sesión: #S, Ventana: #W, Panel: #P"
```

### Si te pierdes:

```bash
# Ver todos los atajos
Ctrl+b ?

# Ver información de la sesión
Ctrl+b s

# Ver información de las ventanas
Ctrl+b w
```

---

## 📚 Próximos Pasos

### Nivel Básico (Ya lo tienes):
- ✅ Dividir paneles
- ✅ Cambiar entre paneles
- ✅ Desconectar y reconectar

### Nivel Intermedio (Aprende ahora):
1. Crear múltiples ventanas
2. Renombrar ventanas
3. Usar modo scroll
4. Buscar en el historial

### Nivel Avanzado (Para después):
1. Personalizar configuración (`.tmux.conf`)
2. Usar scripts de automatización
3. Crear layouts personalizados
4. Sincronizar paneles

---

## 🎓 Recursos de Aprendizaje

### En esta carpeta:
- **cheatsheet.md** - Referencia completa de comandos
- **README.md** - Guía detallada
- **FAQ.md** - Preguntas frecuentes
- **tmux.conf.ejemplo** - Configuración personalizada

### Comandos de ayuda:
```bash
# Manual de tmux
man tmux

# Ayuda interactiva
Ctrl+b ?

# Listar comandos
tmux list-commands
```

---

## 💪 Desafío: Crea tu Primer Workspace

Intenta crear este layout:

```
┌──────────────┬──────────────┐
│              │              │
│   Editor     │   Terminal   │
│   (vim)      │   (comandos) │
│              │              │
├──────────────┴──────────────┤
│                             │
│   Logs / Monitoreo          │
│   (tail -f)                 │
│                             │
└─────────────────────────────┘
```

**Pasos:**
1. `Ctrl+b %` - Dividir verticalmente
2. `Ctrl+b "` - Dividir el panel inferior horizontalmente
3. `Ctrl+b o` - Navegar entre paneles
4. En cada panel, ejecuta el comando que necesites

---

## 🎉 ¡Felicidades!

Ya sabes lo básico de tmux. Ahora puedes:
- ✅ Trabajar con múltiples paneles
- ✅ Mantener sesiones activas
- ✅ Desconectar sin perder tu trabajo
- ✅ Ser más productivo en IBM i

**Siguiente paso:** Personaliza tu configuración copiando `tmux.conf.ejemplo` a `~/.tmux.conf`

---

## 📝 Notas Rápidas

### Recordatorios:
- **Prefijo:** Todos los comandos empiezan con `Ctrl+b`
- **Desconectar:** `Ctrl+b d` (la sesión sigue activa)
- **Ayuda:** `Ctrl+b ?`
- **Scroll:** `Ctrl+b [` (salir con `q`)

### Tips:
- Usa nombres descriptivos para tus sesiones
- Crea una sesión por proyecto
- Desconecta en lugar de cerrar
- Practica los atajos básicos primero

---

**¡Disfruta trabajando con tmux en IBM i! 🚀**