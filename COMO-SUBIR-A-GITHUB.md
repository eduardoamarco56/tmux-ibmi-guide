# 📤 Cómo Subir este Proyecto a GitHub

Esta guía te ayudará a subir el proyecto `tmux-ibmi-guide` a GitHub paso a paso.

---

## 📋 Requisitos Previos

1. ✅ Cuenta de GitHub ([crear cuenta](https://github.com/signup))
2. ✅ Git instalado en tu PC
3. ✅ Todos los archivos del proyecto listos

---

## 🔧 Verificar que Git está Instalado

### En Windows (PowerShell o CMD):
```powershell
git --version
```

### En Linux/Mac:
```bash
git --version
```

Si no está instalado:
- **Windows:** Descarga desde [git-scm.com](https://git-scm.com/download/win)
- **Linux:** `sudo apt install git` (Ubuntu/Debian) o `sudo yum install git` (RHEL/CentOS)
- **Mac:** `brew install git` o descarga desde [git-scm.com](https://git-scm.com/download/mac)

---

## 🚀 Pasos para Subir a GitHub

### Paso 1: Configurar Git (Primera vez)

```bash
git config --global user.name "Tu Nombre"
git config --global user.email "tu@email.com"
```

---

### Paso 2: Crear Repositorio en GitHub

1. Ve a [github.com](https://github.com)
2. Haz clic en el botón **"+"** (arriba derecha) → **"New repository"**
3. Configura el repositorio:
   - **Repository name:** `tmux-ibmi-guide`
   - **Description:** `Guía completa de tmux para IBM i en español`
   - **Visibility:** Public (o Private si prefieres)
   - **NO** marques "Initialize this repository with a README"
4. Haz clic en **"Create repository"**

---

### Paso 3: Inicializar Git en tu Proyecto

Abre PowerShell o Terminal en la carpeta del proyecto:

```bash
# Navegar a la carpeta del proyecto
cd C:\Users\eduar\Desktop\tmux-ibmi-guide

# Inicializar repositorio Git
git init

# Agregar todos los archivos
git add .

# Hacer el primer commit
git commit -m "Initial commit: Guía completa de tmux para IBM i"
```

---

### Paso 4: Renombrar README para GitHub

```bash
# Renombrar README-GITHUB.md a README.md
# En Windows PowerShell:
Move-Item README-GITHUB.md README.md -Force

# En Linux/Mac:
mv README-GITHUB.md README.md

# Agregar el cambio
git add README.md
git commit -m "Rename README for GitHub"
```

---

### Paso 5: Conectar con GitHub

Reemplaza `TU-USUARIO` con tu nombre de usuario de GitHub:

```bash
git remote add origin https://github.com/TU-USUARIO/tmux-ibmi-guide.git
git branch -M main
git push -u origin main
```

**Nota:** GitHub te pedirá autenticación. Usa tu token de acceso personal (no tu contraseña).

---

## 🔑 Crear Token de Acceso Personal

Si GitHub te pide autenticación:

1. Ve a GitHub → **Settings** → **Developer settings** → **Personal access tokens** → **Tokens (classic)**
2. Haz clic en **"Generate new token"** → **"Generate new token (classic)"**
3. Configura:
   - **Note:** `tmux-ibmi-guide`
   - **Expiration:** 90 days (o lo que prefieras)
   - **Scopes:** Marca `repo` (todos los permisos de repositorio)
4. Haz clic en **"Generate token"**
5. **COPIA EL TOKEN** (solo se muestra una vez)
6. Usa este token como contraseña cuando Git te lo pida

---

## 📝 Comandos Git Útiles

### Ver estado del repositorio
```bash
git status
```

### Agregar cambios
```bash
# Agregar archivo específico
git add nombre_archivo.md

# Agregar todos los cambios
git add .
```

### Hacer commit
```bash
git commit -m "Descripción de los cambios"
```

### Subir cambios a GitHub
```bash
git push
```

### Ver historial de commits
```bash
git log --oneline
```

---

## 🔄 Actualizar el Repositorio

Después de hacer cambios en los archivos:

```bash
# 1. Ver qué cambió
git status

# 2. Agregar cambios
git add .

# 3. Hacer commit
git commit -m "Descripción de los cambios"

# 4. Subir a GitHub
git push
```

---

## 📂 Estructura del Repositorio

Después de subir, tu repositorio tendrá:

```
tmux-ibmi-guide/
├── .gitignore
├── LICENSE
├── README.md (principal para GitHub)
├── INDICE.md
├── INICIO-RAPIDO.md
├── INSTRUCCIONES-VALIDACION.md
├── FAQ.md
├── cheatsheet.md
├── tmux.conf.ejemplo
├── scripts-ejemplo.sh
├── monitor-ibmi.sh
├── workspace-completo.sh
├── workspace-mejorado.sh
├── validar-tmux-ibmi.sh
├── validar-tmux-ibmi.bat
└── COMO-SUBIR-A-GITHUB.md (este archivo)
```

---

## ✅ Verificar que Todo Está en GitHub

1. Ve a `https://github.com/TU-USUARIO/tmux-ibmi-guide`
2. Deberías ver:
   - ✅ Todos los archivos listados
   - ✅ El README.md mostrándose en la página principal
   - ✅ La licencia MIT
   - ✅ El archivo .gitignore

---

## 🎨 Personalizar el Repositorio en GitHub

### Agregar Topics (Etiquetas)

1. En tu repositorio, haz clic en el ⚙️ junto a "About"
2. Agrega topics:
   - `ibm-i`
   - `tmux`
   - `pase`
   - `terminal`
   - `multiplexer`
   - `spanish`
   - `documentation`

### Agregar Descripción

En "About", agrega:
```
Guía completa de tmux para IBM i en español. Incluye documentación, scripts y ejemplos prácticos.
```

---

## 🌟 Hacer el Repositorio Más Visible

### 1. Agregar un README atractivo

El README.md ya incluye:
- ✅ Badges
- ✅ Tabla de contenidos
- ✅ Ejemplos de código
- ✅ Documentación clara

### 2. Crear un Release

```bash
# Crear tag
git tag -a v1.0.0 -m "Primera versión completa"

# Subir tag
git push origin v1.0.0
```

Luego en GitHub:
1. Ve a **Releases** → **Create a new release**
2. Selecciona el tag `v1.0.0`
3. Título: `v1.0.0 - Primera Versión Completa`
4. Descripción: Lista de características
5. Publica el release

---

## 🐛 Solución de Problemas

### Error: "remote origin already exists"

```bash
git remote remove origin
git remote add origin https://github.com/TU-USUARIO/tmux-ibmi-guide.git
```

### Error: "failed to push some refs"

```bash
# Primero hacer pull
git pull origin main --rebase

# Luego push
git push origin main
```

### Error: "Authentication failed"

- Asegúrate de usar tu token de acceso personal, no tu contraseña
- Verifica que el token tenga permisos de `repo`

---

## 📞 Ayuda Adicional

- [Documentación de Git](https://git-scm.com/doc)
- [Guía de GitHub](https://docs.github.com/es)
- [Crear Token de Acceso](https://docs.github.com/es/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)

---

## ✨ ¡Listo!

Tu proyecto ahora está en GitHub y disponible para:
- ✅ Compartir con otros
- ✅ Colaborar con la comunidad
- ✅ Recibir contribuciones
- ✅ Hacer seguimiento de versiones

**URL de tu repositorio:**
```
https://github.com/TU-USUARIO/tmux-ibmi-guide
```

---

**¡Felicidades por compartir tu conocimiento con la comunidad! 🎉**