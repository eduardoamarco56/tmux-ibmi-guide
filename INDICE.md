# 📚 Guía Completa de tmux para IBM i - Índice

Bienvenido a la guía completa de **tmux** para **IBM i**. Esta documentación te ayudará a dominar tmux en el entorno PASE de IBM i.

---

## 📖 Contenido de la Guía

### 1. 📘 [README.md](README.md) - Guía Principal
**Descripción:** Documentación completa y detallada sobre tmux en IBM i.

**Contenido:**
- ✅ Introducción a tmux
- ✅ Requisitos previos
- ✅ Instalación paso a paso
- ✅ Configuración básica
- ✅ Comandos esenciales
- ✅ Casos de uso específicos para IBM i
- ✅ Solución de problemas
- ✅ Scripts útiles

**Ideal para:** Aprender desde cero o como referencia completa.

---

### 2. ⚡ [cheatsheet.md](cheatsheet.md) - Referencia Rápida
**Descripción:** Hoja de referencia con todos los comandos y atajos.

**Contenido:**
- 🚀 Inicio rápido
- 📋 Gestión de sesiones
- 🪟 Gestión de ventanas
- 📱 Gestión de paneles
- 📜 Modo copia y scroll
- 💡 Casos de uso comunes
- 🎯 Tips y trucos

**Ideal para:** Consulta rápida mientras trabajas.

---

### 3. ❓ [FAQ.md](FAQ.md) - Preguntas Frecuentes
**Descripción:** Respuestas a las preguntas más comunes.

**Contenido:**
- 🔧 Instalación y configuración
- 💻 Uso básico
- 🐛 Problemas comunes
- ⚡ Rendimiento
- 🔗 Integración con IBM i
- 🎓 Temas avanzados

**Ideal para:** Resolver dudas específicas y troubleshooting.

---

### 4. ⚙️ [tmux.conf.ejemplo](tmux.conf.ejemplo) - Archivo de Configuración
**Descripción:** Archivo de configuración completo y comentado.

**Contenido:**
- ⚙️ Configuración general
- 🎨 Personalización de colores
- ⌨️ Atajos personalizados
- 📊 Barra de estado
- 🔧 Optimizaciones para IBM i

**Ideal para:** Copiar y personalizar tu configuración.

**Uso:**
```bash
# Copiar a tu home
cp tmux.conf.ejemplo ~/.tmux.conf

# Editar según tus necesidades
vim ~/.tmux.conf

# Recargar configuración (dentro de tmux)
Ctrl+b :source-file ~/.tmux.conf
```

---

### 5. 🔨 [scripts-ejemplo.sh](scripts-ejemplo.sh) - Scripts Útiles
**Descripción:** Colección de scripts para automatizar tareas comunes.

**Contenido:**
- 📊 Script de monitoreo del sistema
- 💻 Script de sesión de desarrollo
- 💾 Script de backup con monitoreo
- 🔧 Script de administración
- 📋 Gestión de sesiones
- 🧹 Limpieza de sesiones antiguas
- 🎨 Creación de sesiones personalizadas
- 💾 Guardar layouts

**Ideal para:** Automatizar tu flujo de trabajo.

**Uso:**
```bash
# Dar permisos de ejecución
chmod +x scripts-ejemplo.sh

# Ejecutar menú interactivo
./scripts-ejemplo.sh

# O usar funciones individuales
source scripts-ejemplo.sh
tmux_monitor  # Iniciar sesión de monitoreo
```

---

## 🎯 Rutas de Aprendizaje

### 👶 Principiante
1. Lee la **Introducción** en [README.md](README.md)
2. Sigue la sección **Instalación** en [README.md](README.md)
3. Practica con los **Comandos esenciales** en [cheatsheet.md](cheatsheet.md)
4. Consulta [FAQ.md](FAQ.md) cuando tengas dudas

### 🧑 Intermedio
1. Copia y personaliza [tmux.conf.ejemplo](tmux.conf.ejemplo)
2. Estudia los **Casos de uso en IBM i** en [README.md](README.md)
3. Experimenta con los scripts en [scripts-ejemplo.sh](scripts-ejemplo.sh)
4. Aprende los **Tips y trucos** en [cheatsheet.md](cheatsheet.md)

### 🚀 Avanzado
1. Lee la sección **Avanzado** en [FAQ.md](FAQ.md)
2. Crea tus propios scripts basados en [scripts-ejemplo.sh](scripts-ejemplo.sh)
3. Personaliza completamente tu [tmux.conf.ejemplo](tmux.conf.ejemplo)
4. Implementa automatización y workflows personalizados

---

## 🔍 Búsqueda Rápida por Tema

### Instalación
- 📘 [README.md - Instalación en IBM i](README.md#instalación-en-ibm-i)
- ❓ [FAQ.md - ¿Cómo instalo tmux?](FAQ.md#instalación-y-configuración)

### Configuración
- ⚙️ [tmux.conf.ejemplo](tmux.conf.ejemplo) - Archivo completo
- 📘 [README.md - Configuración básica](README.md#configuración-básica)
- ❓ [FAQ.md - ¿Dónde está el archivo de configuración?](FAQ.md#instalación-y-configuración)

### Comandos y Atajos
- ⚡ [cheatsheet.md](cheatsheet.md) - Referencia completa
- 📘 [README.md - Comandos esenciales](README.md#comandos-esenciales)

### Casos de Uso
- 📘 [README.md - Casos de uso en IBM i](README.md#casos-de-uso-en-ibm-i)
- ⚡ [cheatsheet.md - Casos de uso comunes](cheatsheet.md#casos-de-uso-comunes-en-ibm-i)
- 🔨 [scripts-ejemplo.sh](scripts-ejemplo.sh) - Scripts automatizados

### Problemas y Soluciones
- ❓ [FAQ.md - Problemas comunes](FAQ.md#problemas-comunes)
- 📘 [README.md - Solución de problemas](README.md#solución-de-problemas)

### Integración con IBM i
- ❓ [FAQ.md - Integración con IBM i](FAQ.md#integración-con-ibm-i)
- 📘 [README.md - Casos de uso en IBM i](README.md#casos-de-uso-en-ibm-i)

---

## 📊 Estructura de Archivos

```
tmux-ibmi-guide/
│
├── INDICE.md              ← Estás aquí (navegación)
├── README.md              ← Guía principal completa
├── cheatsheet.md          ← Referencia rápida
├── FAQ.md                 ← Preguntas frecuentes
├── tmux.conf.ejemplo      ← Archivo de configuración
└── scripts-ejemplo.sh     ← Scripts de automatización
```

---

## 🚀 Inicio Rápido (5 minutos)

### Paso 1: Instalar tmux
```bash
ssh usuario@ibmi_host
yum install tmux
```

### Paso 2: Configurar
```bash
cp tmux.conf.ejemplo ~/.tmux.conf
```

### Paso 3: Iniciar
```bash
tmux new -s mi_sesion
```

### Paso 4: Aprender atajos básicos
- `Ctrl+b %` - Dividir verticalmente
- `Ctrl+b "` - Dividir horizontalmente
- `Ctrl+b o` - Cambiar entre paneles
- `Ctrl+b d` - Desconectar (sesión sigue activa)
- `Ctrl+b ?` - Ver todos los atajos

### Paso 5: Reconectar
```bash
tmux attach -t mi_sesion
```

---

## 💡 Consejos de Uso

### Para Consulta Rápida
1. Mantén [cheatsheet.md](cheatsheet.md) abierto en otra ventana
2. Usa `Ctrl+b ?` dentro de tmux para ver atajos
3. Consulta [FAQ.md](FAQ.md) para problemas específicos

### Para Aprendizaje
1. Lee [README.md](README.md) sección por sección
2. Practica cada comando antes de continuar
3. Experimenta con los scripts de [scripts-ejemplo.sh](scripts-ejemplo.sh)

### Para Productividad
1. Personaliza [tmux.conf.ejemplo](tmux.conf.ejemplo) según tu flujo de trabajo
2. Crea scripts personalizados basados en [scripts-ejemplo.sh](scripts-ejemplo.sh)
3. Usa sesiones nombradas para diferentes proyectos

---

## 🔗 Enlaces Útiles

### Documentación Externa
- [Documentación oficial de tmux](https://github.com/tmux/tmux/wiki)
- [IBM i Open Source](https://www.ibm.com/support/pages/node/706903)
- [tmux Cheat Sheet online](https://tmuxcheatsheet.com/)

### Comandos de Ayuda
```bash
man tmux              # Manual completo
tmux list-commands    # Listar todos los comandos
tmux list-keys        # Listar todos los atajos
```

---

## 📝 Notas Importantes

### ⚠️ Limitaciones en IBM i
- ❌ No funciona en sesiones 5250 tradicionales
- ❌ No compatible con QSH (QSHELL nativo)
- ✅ Solo disponible en PASE a través de SSH

### ✅ Ventajas
- Sesiones persistentes (sobreviven a desconexiones)
- Múltiples ventanas y paneles
- Ideal para procesos largos
- Excelente para administración remota

---

## 🆘 ¿Necesitas Ayuda?

1. **Consulta rápida:** [cheatsheet.md](cheatsheet.md)
2. **Problema específico:** [FAQ.md](FAQ.md)
3. **Aprendizaje detallado:** [README.md](README.md)
4. **Ejemplos prácticos:** [scripts-ejemplo.sh](scripts-ejemplo.sh)
5. **Configuración:** [tmux.conf.ejemplo](tmux.conf.ejemplo)

---

## 📅 Información de la Guía

- **Versión:** 1.0
- **Última actualización:** 2026-01-01
- **Plataforma:** IBM i PASE
- **Idioma:** Español

---

## 🎓 Próximos Pasos

Después de dominar lo básico:

1. ✅ Explora plugins de tmux (TPM, tmux-resurrect, etc.)
2. ✅ Crea workflows personalizados para tu trabajo
3. ✅ Automatiza tareas repetitivas con scripts
4. ✅ Comparte tus configuraciones con el equipo
5. ✅ Contribuye con mejoras a esta guía

---

**¡Feliz aprendizaje con tmux en IBM i! 🚀**