#!/bin/bash
# ============================================
# Script para verificar locales disponibles
# ============================================

echo "=========================================="
echo "Verificando locales disponibles en IBM i"
echo "=========================================="
echo ""

echo "1. Locales instalados:"
locale -a
echo ""

echo "2. Locale actual:"
locale
echo ""

echo "3. Variables de entorno:"
echo "LANG=$LANG"
echo "LC_ALL=$LC_ALL"
echo "LC_CTYPE=$LC_CTYPE"
echo ""

echo "4. Probando locales comunes para tmux:"
echo ""

# Probar diferentes locales
for loc in "C.UTF-8" "en_US.utf8" "en_US.UTF-8" "C" "POSIX"; do
    echo -n "Probando $loc... "
    if LC_ALL=$loc locale -a >/dev/null 2>&1; then
        echo "✓ Disponible"
    else
        echo "✗ No disponible"
    fi
done

echo ""
echo "=========================================="
echo "Recomendación:"
echo "Usa uno de los locales marcados con ✓"
echo "=========================================="