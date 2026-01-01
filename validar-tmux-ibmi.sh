#!/bin/bash
# ============================================
# Script de Validación de tmux en IBM i
# ============================================
# Este script verifica si tmux está disponible
# y funciona correctamente en el IBM i
# ============================================

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuración - EDITAR ESTOS VALORES
IBM_HOST="your_ibmi_host"  # Ejemplo: "192.168.1.100" o "ibmi.company.com"
IBM_USER="your_username"    # Ejemplo: "MYUSER"

echo "============================================"
echo "Validación de tmux en IBM i"
echo "============================================"
echo ""
echo "Host: $IBM_HOST"
echo "Usuario: $IBM_USER"
echo ""

# Función para imprimir resultados
print_result() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✓${NC} $2"
    else
        echo -e "${RED}✗${NC} $2"
    fi
}

# Función para imprimir advertencias
print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

# Función para imprimir información
print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

echo "============================================"
echo "PASO 1: Verificando conectividad SSH"
echo "============================================"

# Verificar si podemos hacer ping
ping -c 1 -W 2 $IBM_HOST > /dev/null 2>&1
if [ $? -eq 0 ]; then
    print_result 0 "Host $IBM_HOST es alcanzable"
else
    print_result 1 "No se puede alcanzar el host $IBM_HOST"
    echo ""
    print_warning "Verifica que:"
    echo "  - El servidor IBM i esté encendido"
    echo "  - La IP sea correcta"
    echo "  - No haya firewall bloqueando"
    exit 1
fi

echo ""
echo "============================================"
echo "PASO 2: Verificando acceso SSH"
echo "============================================"
print_info "Intentando conectar por SSH..."
print_warning "Se te pedirá la contraseña del usuario $IBM_USER"
echo ""

# Crear script temporal para ejecutar en el IBM i
REMOTE_SCRIPT=$(cat << 'EOF'
#!/bin/bash

echo "=== Información del Sistema ==="
echo "Hostname: $(hostname)"
echo "Sistema Operativo: $(uname -s)"
echo "Versión: $(uname -r)"
echo ""

echo "=== Verificando PASE ==="
if [ -d "/QOpenSys" ]; then
    echo "✓ Directorio PASE encontrado: /QOpenSys"
else
    echo "✗ Directorio PASE no encontrado"
    exit 1
fi

echo ""
echo "=== Verificando Shell ==="
echo "Shell actual: $SHELL"
if [[ "$SHELL" == *"bash"* ]] || [[ "$SHELL" == *"ksh"* ]]; then
    echo "✓ Shell compatible detectado"
else
    echo "⚠ Shell: $SHELL (puede no ser compatible)"
fi

echo ""
echo "=== Verificando tmux ==="
if command -v tmux &> /dev/null; then
    TMUX_VERSION=$(tmux -V)
    echo "✓ tmux está instalado: $TMUX_VERSION"
    TMUX_INSTALLED=1
else
    echo "✗ tmux NO está instalado"
    TMUX_INSTALLED=0
fi

echo ""
echo "=== Verificando yum ==="
if command -v yum &> /dev/null; then
    echo "✓ yum está disponible"
    YUM_AVAILABLE=1
else
    echo "✗ yum NO está disponible"
    YUM_AVAILABLE=0
fi

echo ""
echo "=== Verificando PATH ==="
echo "PATH actual: $PATH"
if [[ "$PATH" == *"/QOpenSys/pkgs/bin"* ]]; then
    echo "✓ /QOpenSys/pkgs/bin está en el PATH"
else
    echo "⚠ /QOpenSys/pkgs/bin NO está en el PATH"
fi

echo ""
echo "=== Verificando permisos ==="
if [ -w "$HOME" ]; then
    echo "✓ Tienes permisos de escritura en tu HOME: $HOME"
else
    echo "✗ NO tienes permisos de escritura en tu HOME"
fi

echo ""
echo "=== Resumen ==="
if [ $TMUX_INSTALLED -eq 1 ]; then
    echo "Estado: tmux está INSTALADO y listo para usar"
    exit 0
else
    if [ $YUM_AVAILABLE -eq 1 ]; then
        echo "Estado: tmux NO está instalado, pero puede instalarse con yum"
        exit 2
    else
        echo "Estado: tmux NO está instalado y yum no está disponible"
        exit 3
    fi
fi
EOF
)

# Ejecutar script en el IBM i
ssh -o ConnectTimeout=10 -o StrictHostKeyChecking=no ${IBM_USER}@${IBM_HOST} "bash -s" << EOF
$REMOTE_SCRIPT
EOF

SSH_EXIT_CODE=$?

echo ""
echo "============================================"
echo "RESULTADO DE LA VALIDACIÓN"
echo "============================================"

case $SSH_EXIT_CODE in
    0)
        echo -e "${GREEN}✓ ÉXITO${NC}: tmux está instalado y funcionando"
        echo ""
        echo "Próximos pasos:"
        echo "1. Conectarte por SSH: ssh ${IBM_USER}@${IBM_HOST}"
        echo "2. Iniciar tmux: tmux"
        echo "3. O crear sesión con nombre: tmux new -s mi_sesion"
        ;;
    2)
        echo -e "${YELLOW}⚠ ADVERTENCIA${NC}: tmux NO está instalado, pero puede instalarse"
        echo ""
        echo "Para instalar tmux:"
        echo "1. Conectarte por SSH: ssh ${IBM_USER}@${IBM_HOST}"
        echo "2. Ejecutar: yum install tmux"
        echo "3. Verificar: tmux -V"
        ;;
    3)
        echo -e "${RED}✗ ERROR${NC}: tmux NO está instalado y yum no está disponible"
        echo ""
        echo "Necesitas:"
        echo "1. Instalar el gestor de paquetes yum en IBM i"
        echo "2. O instalar tmux manualmente desde RPM"
        echo "3. Contactar al administrador del sistema"
        ;;
    255)
        echo -e "${RED}✗ ERROR${NC}: No se pudo conectar por SSH"
        echo ""
        echo "Posibles causas:"
        echo "1. Contraseña incorrecta"
        echo "2. Usuario no tiene acceso SSH"
        echo "3. SSH no está habilitado en el IBM i"
        echo "4. Firewall bloqueando el puerto 22"
        ;;
    *)
        echo -e "${RED}✗ ERROR${NC}: Error desconocido (código: $SSH_EXIT_CODE)"
        ;;
esac

echo ""
echo "============================================"
echo "Validación completada"
echo "============================================"

exit $SSH_EXIT_CODE