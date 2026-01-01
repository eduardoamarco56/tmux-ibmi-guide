# 🔍 Instrucciones para Validar tmux en IBM i

Este documento explica cómo usar los scripts de validación para verificar si tmux está disponible en tu servidor IBM i.

---

## 📋 Configuración Inicial

Antes de usar los scripts, debes editar los archivos de validación con tu información:

### En `validar-tmux-ibmi.sh` (Linux/Mac):
```bash
IBM_HOST="your_ibmi_host"  # Tu IP o hostname
IBM_USER="your_username"    # Tu usuario
```

### En `validar-tmux-ibmi.bat` (Windows):
```batch
set IBM_HOST=your_ibmi_host
set IBM_USER=your_username
```

---

## 🚀 Opción 1: Script de Windows (Recomendado)

### Paso 1: Editar el script

1. Abre `validar-tmux-ibmi.bat` con un editor de texto
2. Cambia `your_ibmi_host` por tu IP o hostname (ej: `192.168.1.100`)
3. Cambia `your_username` por tu usuario (ej: `MYUSER`)
4. Guarda el archivo

### Paso 2: Ejecutar el script

1. Haz doble clic en `validar-tmux-ibmi.bat`
2. Ingresa tu contraseña cuando se solicite

### Paso 3: Interpretar resultados

El script mostrará uno de estos resultados:

#### ✅ **ÉXITO: tmux está instalado**
```
[EXITO] tmux esta instalado y funcionando

Proximos pasos:
1. Conectarte por SSH: ssh USUARIO@HOST
2. Iniciar tmux: tmux
3. O crear sesion con nombre: tmux new -s mi_sesion
```

**Acción:** ¡Puedes empezar a usar tmux! Continúa con la sección "Primeros Pasos".

---

#### ⚠️ **ADVERTENCIA: tmux NO está instalado (pero puede instalarse)**
```
[ADVERTENCIA] tmux NO esta instalado, pero puede instalarse

Para instalar tmux:
1. Conectarte por SSH: ssh USUARIO@HOST
2. Ejecutar: yum install tmux
3. Verificar: tmux -V
```

**Acción:** Sigue las instrucciones de instalación más abajo.

---

#### ❌ **ERROR: tmux NO está instalado y yum no disponible**
```
[ERROR] tmux NO esta instalado y yum no esta disponible

Necesitas:
1. Instalar el gestor de paquetes yum en IBM i
2. O instalar tmux manualmente desde RPM
3. Contactar al administrador del sistema
```

**Acción:** Contacta al administrador del sistema IBM i.

---

## 🐧 Opción 2: Script de Linux/Mac

Si estás usando Linux, Mac, o WSL en Windows:

### Paso 1: Editar el script

```bash
cd tmux-ibmi-guide
nano validar-tmux-ibmi.sh  # o usa tu editor preferido
```

Cambia estas líneas:
```bash
IBM_HOST="your_ibmi_host"  # Tu IP o hostname
IBM_USER="your_username"    # Tu usuario
```

### Paso 2: Dar permisos de ejecución

```bash
chmod +x validar-tmux-ibmi.sh
```

### Paso 3: Ejecutar el script

```bash
./validar-tmux-ibmi.sh
```

### Paso 4: Ingresar contraseña

Cuando se te solicite, ingresa tu contraseña.

---

## 🔧 Opción 3: Validación Manual

Si prefieres hacerlo manualmente:

### Paso 1: Conectar por SSH

```bash
ssh USUARIO@HOST
```

### Paso 2: Verificar PASE

```bash
echo $SHELL
# Debe mostrar algo como: /QOpenSys/pkgs/bin/bash
```

### Paso 3: Verificar tmux

```bash
which tmux
# Si está instalado, mostrará la ruta
# Si no está instalado, no mostrará nada

tmux -V
# Si está instalado, mostrará la versión
```

### Paso 4: Verificar yum (si tmux no está instalado)

```bash
which yum
# Si está disponible, mostrará la ruta

yum --version
# Si está disponible, mostrará la versión
```

---

## 📦 Instalación de tmux (si no está instalado)

### Método 1: Usando yum (Recomendado)

```bash
# Conectar por SSH
ssh USUARIO@HOST

# Actualizar repositorios
yum update

# Instalar tmux
yum install tmux

# Verificar instalación
tmux -V
```

### Método 2: Usando rpm

Si tienes el archivo RPM de tmux:

```bash
# Conectar por SSH
ssh USUARIO@HOST

# Instalar desde RPM
rpm -ivh tmux-*.rpm

# Verificar instalación
tmux -V
```

---

## 🎯 Primeros Pasos después de la Instalación

### 1. Conectar por SSH

```bash
ssh USUARIO@HOST
```

### 2. Iniciar tmux

```bash
# Opción 1: Sesión simple
tmux

# Opción 2: Sesión con nombre
tmux new -s prueba
```

### 3. Probar comandos básicos

Dentro de tmux:

```bash
# Dividir pantalla verticalmente
Ctrl+b %

# Dividir pantalla horizontalmente
Ctrl+b "

# Cambiar entre paneles
Ctrl+b o

# Desconectar (la sesión sigue activa)
Ctrl+b d
```

### 4. Reconectar a la sesión

```bash
# Listar sesiones
tmux ls

# Reconectar
tmux attach -t prueba
```

---

## 🧪 Prueba Completa Recomendada

Una vez que tmux esté instalado, ejecuta esta prueba:

```bash
# 1. Conectar por SSH
ssh USUARIO@HOST

# 2. Crear sesión de prueba
tmux new -s test

# 3. Ejecutar comando largo (simulación)
sleep 30 && echo "Prueba completada"

# 4. Desconectar (Ctrl+b d)
# El comando seguirá ejecutándose

# 5. Listar sesiones
tmux ls
# Deberías ver: test: 1 windows (created ...)

# 6. Reconectar
tmux attach -t test
# Deberías ver el mensaje "Prueba completada"

# 7. Cerrar sesión
exit
```

---

## ❓ Solución de Problemas

### Problema: "ssh: command not found"

**En Windows:**
1. Abre PowerShell como administrador
2. Ejecuta: `Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0`
3. O instala Git Bash o WSL

**En Linux/Mac:**
- SSH debería estar instalado por defecto
- Si no: `sudo apt install openssh-client` (Ubuntu/Debian)
- O: `sudo yum install openssh-clients` (RHEL/CentOS)

---

### Problema: "Permission denied (publickey,password)"

**Causas posibles:**
1. Contraseña incorrecta
2. Usuario no tiene acceso SSH
3. SSH no está habilitado para el usuario

**Solución:**
1. Verifica la contraseña
2. Contacta al administrador del sistema IBM i
3. Verifica que SSH esté habilitado en el IBM i

---

### Problema: "Connection timed out"

**Causas posibles:**
1. Servidor IBM i apagado
2. Firewall bloqueando puerto 22
3. IP incorrecta

**Solución:**
1. Verifica que el servidor esté encendido
2. Verifica la IP con ping
3. Contacta al administrador de red

---

### Problema: "bash: tmux: command not found"

**Causa:** tmux no está instalado

**Solución:**
```bash
# Verificar si yum está disponible
which yum

# Si está disponible, instalar tmux
yum install tmux

# Si no está disponible, contactar al administrador
```

---

## 📞 Contacto con el Administrador

Si necesitas ayuda del administrador del sistema IBM i, proporciona esta información:

```
Solicitud: Instalación de tmux en IBM i

Detalles:
- Host: [TU_HOST]
- Usuario: [TU_USUARIO]
- Requisito: tmux (Terminal Multiplexer)
- Propósito: Gestión de sesiones de terminal persistentes

Información técnica:
- tmux debe instalarse en el entorno PASE
- Requiere acceso SSH
- Instalación vía yum: yum install tmux
- O vía RPM desde repositorios de IBM i Open Source

Documentación:
- https://github.com/tmux/tmux
- https://www.ibm.com/support/pages/node/706903
```

---

## 📚 Próximos Pasos

Una vez que tmux esté funcionando:

1. ✅ Lee el [README.md](README.md) para documentación completa
2. ✅ Consulta el [cheatsheet.md](cheatsheet.md) para referencia rápida
3. ✅ Copia el archivo [tmux.conf.ejemplo](tmux.conf.ejemplo) a `~/.tmux.conf`
4. ✅ Prueba los scripts de [scripts-ejemplo.sh](scripts-ejemplo.sh)
5. ✅ Revisa el [FAQ.md](FAQ.md) para preguntas comunes

---

## 🎓 Recursos Adicionales

- [Documentación oficial de tmux](https://github.com/tmux/tmux/wiki)
- [IBM i Open Source](https://www.ibm.com/support/pages/node/706903)
- [Guía de PASE](https://www.ibm.com/support/pages/pase-ibm-i)

---

**¡Buena suerte con la validación! 🚀**