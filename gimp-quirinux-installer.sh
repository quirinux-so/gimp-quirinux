#!/bin/bash
# ==============================================================
# Nombre:            install-gimp-quirinux.sh
# Autor:             Charlie Martínez® <cmartinez@quirinux.org>
# Licencia:          https://www.gnu.org/licenses/gpl-3.0.txt
# Utilidad:          Instala el Configurador Quirinux para GIMP
# Distro:            Quirinux, Debian 12 y 13, Devuan 5 y 6
# ==============================================================
# Ejecutar como ROOT (sin sudo)
# ==============================================================

clear

echo ""
echo "====> Verificando que esté instalado wget..."
if ! command -v wget >/dev/null 2>&1; then
    echo "====>  wget no está instalado. Instalando..."
    apt update
    apt install -y wget
else
    echo "====>  wget ya está instalado."
fi

echo "====> Creando carpeta de destino /tmp/gimp-quirinux..."
DEST="/tmp/gimp-quirinux"
mkdir -p "$DEST"

# ==============================================================
# Detectar versión compatible de libgimp2.0 requerida por gimp
# ==============================================================

echo "====> Analizando versión compatible de libgimp2.0 requerida por gimp..."
apt update

REQ_VERSION=$(apt-cache depends gimp | grep libgimp2.0 | head -n1 | sed 's/.*(<= //;s/)//')

if [ -z "$REQ_VERSION" ]; then
    echo "====> ERROR: No se pudo detectar la versión requerida de libgimp2.0"
    exit 1
fi

echo "====> gimp requiere libgimp2.0 <= $REQ_VERSION"

if apt-cache madison libgimp2.0 | grep -q "$REQ_VERSION"; then
    echo "====> Versión compatible encontrada en los repositorios."
    apt install -y "libgimp2.0=$REQ_VERSION"
    DESCARGAR_LIBGIMP="no"
else
    echo "====> Versión NO encontrada en los repositorios."
    echo "====> Se descargará desde repo.quirinux.org"
    DESCARGAR_LIBGIMP="si"
fi

# ==============================================================
# Lista de URLs base (sin libgimp2.0)
# ==============================================================

URLS=(
"https://repo.quirinux.org/pool/main/g/gluas/gimp-gluas_0.1.20-2_amd64.deb"
"https://repo.quirinux.org/pool/main/g/gmic/gimp-gmic_2.9.5-4+b4_amd64.deb"
"https://repo.quirinux.org/pool/main/g/gutenprint/libgutenprintui2-2_5.3.4.20220624T01008808d602-1_amd64.deb"
"https://repo.quirinux.org/pool/main/g/gutenprint/gimp-gutenprint_5.3.4.20220624T01008808d602-1_amd64.deb"
"https://repo.quirinux.org/pool/main/g/gimplensfun/gimp-lensfun_0.2.5-1.1_amd64.deb"
"https://repo.quirinux.org/pool/main/libj/libjpeg-turbo/libjpeg62-turbo_2.1.5-4_amd64.deb"
"https://repo.quirinux.org/pool/main/g/gimp-plugin-registry/gimp-plugin-registry_9.20200929+b1_amd64.deb"
"https://repo.quirinux.org/pool/main/g/gtkam/gtkam-gimp_1.0-3+b1_amd64.deb"
"https://repo.quirinux.org/pool/main/g/gimp-gap/gimp-gap_2.6.1_amd64.deb"
"https://repo.quirinux.org/pool/main/g/gimp-quirinux/gimp-quirinux_6.5.4_all.deb"
)

# ==============================================================
# Añadir libgimp2.0 SOLO si no existe en repos
# ==============================================================

if [ "$DESCARGAR_LIBGIMP" = "si" ]; then
    URLS+=("https://repo.quirinux.org/pool/main/g/gimp/libgimp2.0_${REQ_VERSION}_amd64.deb")
fi

# ==============================================================
# Descargar paquetes
# ==============================================================

echo "====> Descargando paquetes .deb necesarios..."
for url in "${URLS[@]}"; do
    wget -P "$DEST" "$url"
done

# ==============================================================
# Instalación (orden correcto anti-roturas)
# ==============================================================

echo "====> Instalando paquetes..."

apt install -y mplayer
apt install --reinstall -y /tmp/gimp-quirinux/*.deb
apt install --reinstall -y gimp

# ==============================================================
# Final
# ==============================================================

echo ""
echo "==========================================================="
echo " INSTALACIÓN COMPLETA"
echo "==========================================================="
echo " Accede al Configurador Quirinux de GIMP desde:"
echo " >>> Menu Aplicaciones > Configuración > Configurar GIMP"
echo ""
echo "==========================================================="
echo ""
