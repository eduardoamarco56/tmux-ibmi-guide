# 🚀 Guía Completa de tmux para IBM i

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![IBM i](https://img.shields.io/badge/IBM%20i-PASE-blue.svg)](https://www.ibm.com/it-infrastructure/power/os/ibm-i)
[![tmux](https://img.shields.io/badge/tmux-3.x-green.svg)](https://github.com/tmux/tmux)

Documentación completa en español para usar **tmux** (Terminal Multiplexer) en **IBM i PASE**. Incluye guías, scripts, ejemplos y solución de problemas.

---

## 📋 Tabla de Contenidos

- [¿Qué es tmux?](#qué-es-tmux)
- [¿Por qué usar tmux en IBM i?](#por-qué-usar-tmux-en-ibm-i)
- [Requisitos](#requisitos)
- [Instalación](#instalación)
- [Documentación](#documentación)
- [Scripts Incluidos](#scripts-incluidos)
- [Inicio Rápido](#inicio-rápido)
- [Contribuir](#contribuir)
- [Licencia](#licencia)

---

## 🎯 ¿Qué es tmux?

**tmux** (Terminal Multiplexer) es una herramienta que permite:

- ✅ Ejecutar múltiples programas en una sola ventana de terminal
- ✅ Mantener sesiones activas incluso después de desconectarse
- ✅ Dividir la pantalla en múltiples paneles
- ✅ Crear y gestionar múltiples ventanas
- ✅ Compartir sesiones entre usuarios

---

## 💡 ¿Por qué usar tmux en IBM i?

### Ventajas específicas para IBM i:

1. **Sesiones persistentes**: Mantén procesos largos ejecutándose sin preocuparte por desconexiones SSH
2. **Monitoreo simultáneo**: Observa múltiples aspectos del sistema al mismo tiempo
3. **Administración eficiente**: Gestiona DB2, trabajos y archivos en una sola pantalla
4. **Productividad**: Reduce el tiempo de cambio entre tareas
5. **Trabajo remoto**: Ideal para administración remota de sistemas IBM i

---

## 📦 Requisitos

### En el IBM i:
- ✅ IBM i 7.2 o superior
- ✅ PASE (Portable Application Solutions Environment) instalado
- ✅ Acceso SSH habilitado
- ✅ Usuario con permisos adecuados

### En tu PC:
- ✅ Cliente SSH (OpenSSH, PuTTY, etc.)
- ✅ Windows 10/11, Linux, o macOS

---

## 🔧 Instalación

### 1. Verificar si tmux está instalado

```bash
ssh usuario@tu_ibmi_host
tmux -V
```

### 2. Instalar tmux (si no está instalado)

```bash
# Usando yum (recomendado)
yum install tmux

# O usando rpm
rpm -ivh tmux-*.rpm
```

### 3. Verificar instalación

```bash
tmux -V
# Debería mostrar: tmux 3.x
```

---

## 📚 Documentación

Este repositorio incluye documentación completa en español:

| Archivo | Descripción | Líneas |
|---------|-------------|--------|
| **[README.md](README.md)** | Guía principal completa | 485 |
| **[INICIO-RAPIDO.md](INICIO-RAPIDO.md)** | Guía de inicio rápido | 429 |
| **[cheatsheet.md](cheatsheet.md)** | Referencia rápida de comandos | 398 |
| **[FAQ.md](FAQ.md)** | Preguntas frecuentes | 534 |
| **[INDICE.md](INDICE.md)** | Índice de navegación | 329 |
| **[INSTRUCCIONES-VALIDACION.md](INSTRUCCIONES-VALIDACION.md)** | Guía de validación | 357 |

---

## 🔨 Scripts Incluidos

### Scripts de Validación

- **`validar-tmux-ibmi.sh`** - Script de validación para Linux/Mac
- **`validar-tmux-ibmi.bat`** - Script de validación para Windows

### Scripts de Configuración

- **`tmux.conf.ejemplo`** - Archivo de configuración completo y comentado

### Scripts de Automatización

- **`scripts-ejemplo.sh`** - Colección de scripts útiles:
  - Sesión de monitoreo del sistema
  - Sesión de desarrollo
  - Sesión de backup con monitoreo
  - Sesión de administración
  - Gestión de sesiones

### Scripts de Workspace

- **`monitor-ibmi.sh`** - Workspace simple de monitoreo
- **`workspace-completo.sh`** - Workspace completo (4 ventanas, 10 paneles)
- **`workspace-mejorado.sh`** - Workspace profesional (5 ventanas, 13 paneles)

---

## 🚀 Inicio Rápido

### 1. Clonar el repositorio

```bash
git clone https://github.com/tu-usuario/tmux-ibmi-guide.git
cd tmux-ibmi-guide
```

### 2. Validar tmux en tu IBM i

**En Windows:**
1. Edita `validar-tmux-ibmi.bat` con tu host y usuario
2. Ejecuta el script

**En Linux/Mac:**
```bash
chmod +x validar-tmux-ibmi.sh
./validar-tmux-ibmi.sh
```

### 3. Conectar y usar tmux

```bash
# Conectar por SSH
ssh usuario@tu_ibmi_host

# Crear sesión
tmux new -s mi_sesion

# Dividir pantalla verticalmente
Ctrl+b %

# Dividir pantalla horizontalmente
Ctrl+b "

# Cambiar entre paneles
Ctrl+b o

# Desconectar (sesión sigue activa)
Ctrl+b d

# Reconectar
tmux attach -t mi_sesion
```

---

## 📖 Ejemplos de Uso

### Ejemplo 1: Monitoreo del Sistema

```bash
# Crear sesión de monitoreo
tmux new -s monitor

# Panel 1: Procesos
ps aux | head -20

# Dividir verticalmente (Ctrl+b %)
# Panel 2: Espacio en disco
df

# Dividir horizontalmente (Ctrl+b ")
# Panel 3: Usuarios conectados
who
```

### Ejemplo 2: Administración de DB2

```bash
# Crear sesión DB2
tmux new -s db2

# Panel 1: Consultas
db2

# Nueva ventana (Ctrl+b c)
# Ventana 2: Monitoreo de aplicaciones
watch -n 10 'db2 list applications show detail'
```

### Ejemplo 3: Desarrollo

```bash
# Crear sesión de desarrollo
tmux new -s dev

# Ventana 1: Editor
vim programa.rpgle

# Ventana 2: Compilación
# Ventana 3: Testing
```

---

## 🎓 Comandos Esenciales

### Gestión de Sesiones

```bash
tmux new -s nombre          # Crear sesión
tmux ls                     # Listar sesiones
tmux attach -t nombre       # Conectar a sesión
tmux kill-session -t nombre # Eliminar sesión
Ctrl+b d                    # Desconectar
```

### Gestión de Ventanas

```bash
Ctrl+b c        # Crear ventana
Ctrl+b ,        # Renombrar ventana
Ctrl+b n        # Siguiente ventana
Ctrl+b p        # Ventana anterior
Ctrl+b 0-9      # Ir a ventana específica
```

### Gestión de Paneles

```bash
Ctrl+b %        # Dividir verticalmente
Ctrl+b "        # Dividir horizontalmente
Ctrl+b o        # Cambiar entre paneles
Ctrl+b x        # Cerrar panel
Ctrl+b z        # Maximizar/restaurar panel
```

---

## 🛠️ Personalización

### Copiar configuración de ejemplo

```bash
# En el IBM i
cp tmux.conf.ejemplo ~/.tmux.conf

# Editar según tus necesidades
vim ~/.tmux.conf

# Recargar configuración (dentro de tmux)
Ctrl+b :source-file ~/.tmux.conf
```

---

## 🤝 Contribuir

¡Las contribuciones son bienvenidas! Si quieres mejorar esta guía:

1. Fork el repositorio
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

---

## 📝 Notas Importantes

### ⚠️ Limitaciones en IBM i

- ❌ tmux NO funciona en sesiones 5250 tradicionales
- ❌ NO compatible con QSH (QSHELL nativo)
- ✅ Solo disponible en PASE a través de SSH

### ✅ Compatibilidad

- ✅ IBM i 7.2+
- ✅ PASE con bash o ksh
- ✅ SSH habilitado
- ✅ tmux 2.x o 3.x

---

## 📞 Soporte

Si encuentras problemas:

1. Revisa el [FAQ.md](FAQ.md)
2. Consulta la [documentación completa](README.md)
3. Abre un [issue](https://github.com/tu-usuario/tmux-ibmi-guide/issues)

---

## 🌟 Recursos Adicionales

- [Documentación oficial de tmux](https://github.com/tmux/tmux/wiki)
- [IBM i Open Source](https://www.ibm.com/support/pages/node/706903)
- [PASE para IBM i](https://www.ibm.com/support/pages/pase-ibm-i)
- [tmux Cheat Sheet](https://tmuxcheatsheet.com/)

---

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo [LICENSE](LICENSE) para más detalles.

---

## ✨ Agradecimientos

- Comunidad de tmux
- Comunidad de IBM i Open Source
- Todos los contribuidores

---

## 📊 Estadísticas del Proyecto

- **Documentación:** 2,500+ líneas
- **Scripts:** 8 archivos ejecutables
- **Ejemplos:** 50+ casos de uso
- **Idioma:** Español
- **Plataforma:** IBM i PASE

---

**Hecho con ❤️ para la comunidad IBM i**

**⭐ Si te resulta útil, dale una estrella al repositorio!**