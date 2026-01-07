# 📚 Comandos Útiles para IBM i - Guía de Referencia Rápida

Esta guía contiene comandos útiles para ejecutar en sesiones SSH del IBM i.

---

## 📁 Navegación y Archivos

### Comandos básicos de navegación
```bash
# Ver directorio actual
pwd

# Listar archivos
ls
ls -la              # Lista detallada con archivos ocultos
ls -lh              # Lista con tamaños legibles

# Cambiar de directorio
cd /home/EAMARCO
cd /QSYS.LIB/
cd ..               # Directorio padre
cd ~                # Directorio home

# Crear directorio
mkdir nombre_directorio
mkdir -p ruta/completa/directorio

# Ver contenido de archivo
cat archivo.txt
more archivo.txt
less archivo.txt
head -20 archivo.txt    # Primeras 20 líneas
tail -20 archivo.txt    # Últimas 20 líneas
tail -f archivo.log     # Ver archivo en tiempo real
```

### Operaciones con archivos
```bash
# Copiar archivos
cp origen destino
cp -r directorio/ destino/    # Copiar directorio recursivamente

# Mover/renombrar
mv origen destino

# Eliminar
rm archivo
rm -r directorio/             # Eliminar directorio
rm -f archivo                 # Forzar eliminación

# Buscar archivos
find /home/EAMARCO -name "*.txt"
find . -type f -name "*.rpgle"
find . -mtime -7              # Archivos modificados últimos 7 días

# Buscar contenido en archivos
grep "texto" archivo.txt
grep -r "texto" directorio/
grep -i "texto" archivo.txt   # Ignorar mayúsculas/minúsculas
```

### Edición de archivos
```bash
# Editores disponibles
vim archivo.txt
vi archivo.txt
nano archivo.txt

# Ver diferencias entre archivos
diff archivo1.txt archivo2.txt
```

---

## 📊 Monitoreo del Sistema

### Procesos
```bash
# Ver procesos en tiempo real
top
htop                # Si está instalado

# Listar todos los procesos
ps aux
ps aux | grep nombre_proceso

# Ver procesos de un usuario
ps -u EAMARCO

# Matar un proceso
kill PID
kill -9 PID         # Forzar terminación

# Ver árbol de procesos
pstree
```

### Recursos del sistema
```bash
# Uso de disco
df                  # Espacio en disco
df -h               # Formato legible
du -sh directorio/  # Tamaño de directorio
du -h --max-depth=1 # Tamaño de subdirectorios

# Memoria
free -h             # Si está disponible
vmstat              # Estadísticas de memoria virtual

# CPU y carga
uptime              # Tiempo activo y carga
w                   # Usuarios y carga
```

### Usuarios y sesiones
```bash
# Ver usuarios conectados
who
w
users

# Ver historial de logins
last
last -n 10          # Últimos 10 logins

# Ver información del usuario actual
whoami
id
```

---

## 🗄️ Base de Datos DB2

### Iniciar DB2
```bash
# Entrar a DB2 interactivo
db2

# Ejecutar comando DB2 desde bash
db2 "SELECT * FROM QSYS2.SYSTABLES FETCH FIRST 10 ROWS ONLY"
```

### Consultas comunes en DB2
```sql
-- Ver tablas del sistema
SELECT * FROM QSYS2.SYSTABLES WHERE TABLE_SCHEMA = 'BIBLIOTECA';

-- Ver columnas de una tabla
SELECT * FROM QSYS2.SYSCOLUMNS WHERE TABLE_NAME = 'TABLA';

-- Ver trabajos activos
SELECT * FROM TABLE(QSYS2.ACTIVE_JOB_INFO()) WHERE JOB_NAME LIKE '%NOMBRE%';

-- Ver usuarios
SELECT * FROM QSYS2.USER_INFO;

-- Ver bibliotecas
SELECT * FROM QSYS2.LIBRARY_LIST_INFO;
```

### Comandos DB2 útiles
```bash
# Dentro de db2:
db2 => list tables
db2 => describe table BIBLIOTECA.TABLA
db2 => connect to DATABASE
db2 => quit
```

---

## 🔧 Comandos CL desde SSH

### Ejecutar comandos CL
```bash
# Sintaxis general
system "COMANDO_CL"

# Ejemplos comunes
system "WRKACTJOB"              # Ver trabajos activos
system "DSPMSG QSYSOPR"         # Ver mensajes del sistema
system "WRKSBMJOB"              # Ver trabajos enviados
system "WRKSBSD"                # Ver subsistemas
system "DSPLIBL"                # Ver lista de bibliotecas
system "WRKSPLF"                # Ver archivos spool
system "WRKOBJ OBJ(LIB/*ALL)"   # Ver objetos de biblioteca
```

### Trabajos y subsistemas
```bash
system "WRKACTJOB"              # Trabajos activos
system "WRKJOB JOB(nombre)"     # Detalles de trabajo
system "ENDJOB JOB(nombre)"     # Terminar trabajo
system "WRKSBSD"                # Subsistemas
system "STRSBS SBSD(nombre)"    # Iniciar subsistema
system "ENDSBS SBS(nombre)"     # Terminar subsistema
```

### Objetos y bibliotecas
```bash
system "DSPLIB LIB(nombre)"     # Información de biblioteca
system "DSPFD FILE(LIB/ARCHIVO)" # Descripción de archivo
system "DSPPFM FILE(LIB/ARCHIVO)" # Ver contenido de archivo físico
system "WRKOBJ OBJ(LIB/OBJ*)"   # Trabajar con objetos
```

### Compilación
```bash
# Compilar RPG
system "CRTBNDRPG PGM(LIB/PROG) SRCFILE(LIB/QRPGLESRC)"

# Compilar COBOL
system "CRTBNDCBL PGM(LIB/PROG) SRCFILE(LIB/QCBLLESRC)"

# Compilar CL
system "CRTBNDCL PGM(LIB/PROG) SRCFILE(LIB/QCLSRC)"

# Ver errores de compilación
system "WRKSPLF SELECT(EAMARCO)"
```

---

## 🌐 Red y Conectividad

### Información de red
```bash
# Ver configuración de red
ifconfig
ip addr

# Ver conexiones activas
netstat -an
netstat -tulpn      # Puertos en escucha

# Ping
ping 192.168.50.225
ping -c 4 hostname  # 4 paquetes

# Ver rutas
route -n
ip route

# DNS
nslookup hostname
dig hostname
```

### Transferencia de archivos
```bash
# SCP (desde otra máquina)
scp archivo.txt EAMARCO@192.168.50.225:/home/EAMARCO/
scp EAMARCO@192.168.50.225:/home/EAMARCO/archivo.txt .

# FTP
ftp 192.168.50.225
```

---

## 📝 Logs y Auditoría

### Ver logs del sistema
```bash
# Logs generales
tail -f /var/log/messages
tail -f /var/log/syslog

# Logs de aplicaciones
ls /var/log/
tail -100 /var/log/nombre.log

# Buscar en logs
grep "ERROR" /var/log/messages
grep -i "error" /var/log/* 2>/dev/null
```

### Historial de comandos
```bash
# Ver historial
history
history | grep comando

# Ejecutar comando del historial
!número
!!                  # Último comando

# Buscar en historial
Ctrl+R              # Búsqueda interactiva
```

---

## 🔐 Permisos y Seguridad

### Permisos de archivos
```bash
# Ver permisos
ls -l archivo

# Cambiar permisos
chmod 755 archivo
chmod +x script.sh
chmod u+w archivo   # Usuario: escritura
chmod g-r archivo   # Grupo: quitar lectura

# Cambiar propietario
chown usuario archivo
chown usuario:grupo archivo
chown -R usuario directorio/
```

### Información de seguridad
```bash
# Ver grupos del usuario
groups
groups EAMARCO

# Ver información de usuario
id
id EAMARCO
```

---

## 🛠️ Utilidades Generales

### Compresión y archivos
```bash
# TAR
tar -czf archivo.tar.gz directorio/
tar -xzf archivo.tar.gz

# ZIP
zip -r archivo.zip directorio/
unzip archivo.zip

# GZIP
gzip archivo
gunzip archivo.gz
```

### Información del sistema
```bash
# Información del sistema
uname -a            # Todo
uname -r            # Versión del kernel
hostname            # Nombre del host

# Fecha y hora
date
date "+%Y-%m-%d %H:%M:%S"
cal                 # Calendario

# Tiempo de actividad
uptime
```

### Variables de entorno
```bash
# Ver variables
env
printenv
echo $PATH
echo $HOME

# Configurar variable
export VARIABLE=valor
export PATH=$PATH:/nueva/ruta
```

---

## 🚀 Comandos Avanzados

### Pipes y redirección
```bash
# Pipe (|)
ps aux | grep java
ls -la | more
cat archivo.txt | grep "texto" | wc -l

# Redirección de salida
comando > archivo.txt       # Sobrescribir
comando >> archivo.txt      # Agregar
comando 2> errores.txt      # Errores
comando &> todo.txt         # Todo

# Entrada desde archivo
comando < archivo.txt
```

### Ejecución en segundo plano
```bash
# Ejecutar en background
comando &

# Ver trabajos en background
jobs

# Traer a foreground
fg %1

# Enviar a background
bg %1

# Desconectar proceso del terminal
nohup comando &
```

### Búsqueda y filtrado
```bash
# Encontrar archivos grandes
find / -type f -size +100M

# Archivos modificados recientemente
find . -mtime -1

# Contar líneas, palabras, caracteres
wc archivo.txt
wc -l archivo.txt           # Solo líneas

# Ordenar
sort archivo.txt
sort -r archivo.txt         # Reverso
sort -n archivo.txt         # Numérico

# Eliminar duplicados
sort archivo.txt | uniq
```

---

## 💡 Tips y Trucos

### Atajos de teclado
```
Ctrl+C          # Cancelar comando
Ctrl+D          # Salir (EOF)
Ctrl+Z          # Suspender proceso
Ctrl+L          # Limpiar pantalla
Ctrl+R          # Buscar en historial
Ctrl+A          # Inicio de línea
Ctrl+E          # Fin de línea
Ctrl+U          # Borrar línea
Tab             # Autocompletar
```

### Alias útiles
```bash
# Crear alias
alias ll='ls -la'
alias ..='cd ..'
alias h='history'

# Ver alias
alias

# Guardar alias permanentemente
echo "alias ll='ls -la'" >> ~/.bashrc
source ~/.bashrc
```

### Comandos encadenados
```bash
# Ejecutar si el anterior tuvo éxito
comando1 && comando2

# Ejecutar si el anterior falló
comando1 || comando2

# Ejecutar ambos sin importar resultado
comando1 ; comando2
```

---

## 📚 Recursos Adicionales

### Ayuda y documentación
```bash
# Manual de comando
man comando
man ls

# Ayuda breve
comando --help
ls --help

# Información de comando
which comando
whereis comando
type comando
```

### Información del sistema IBM i
```bash
# Versión de IBM i
system "DSPSFWRSC"

# Información de PTFs
system "DSPPTF"

# Estado del sistema
system "WRKSYSSTS"
```

---

## 🎯 Ejemplos de Uso Práctico

### Monitoreo continuo
```bash
# Ver logs en tiempo real
tail -f /var/log/messages

# Monitorear procesos
watch -n 5 'ps aux | head -20'

# Ver uso de disco cada 10 segundos
watch -n 10 df -h
```

### Análisis de logs
```bash
# Contar errores en log
grep -c "ERROR" /var/log/messages

# Ver últimos 100 errores
grep "ERROR" /var/log/messages | tail -100

# Errores de hoy
grep "$(date +%Y-%m-%d)" /var/log/messages | grep ERROR
```

### Limpieza y mantenimiento
```bash
# Encontrar archivos temporales
find /tmp -type f -mtime +7

# Limpiar archivos antiguos
find /tmp -type f -mtime +30 -delete

# Ver archivos más grandes
du -ah /home/EAMARCO | sort -rh | head -20
```

---

**Guía creada para el proyecto tmux-ibmi-guide**
**Última actualización: 2026-01-07**