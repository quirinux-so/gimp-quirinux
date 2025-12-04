#!/bin/bash
# ==============================================================
# Nombre:            install-gimp-quirinux.sh
# Autor:             Charlie Martínez®
# Licencia:          GPL-3
# Utilidad:          Instala el Configurador Quirinux para GIMP
# Distro:            Quirinux, Debian 12 y 13, Devuan 5 y 6
# ==============================================================
# Ejecutar como ROOT (sin sudo)
# ==============================================================

clear

echo "====> Verificando wget..."
if ! command -v wget >/dev/null 2>&1; then
    apt update
    apt install -y wget
fi

DEST="/tmp/gimp-quirinux"
mkdir -p "$DEST"

# ==============================================================
# 1) VERIFICAR SI libgimp2.0 EXISTE EN REPO QUIRINUX
# ==============================================================

QUIRINUX_LIB_URL="https://repo.quirinux.org/pool/main/g/gimp/"
QUIRINUX_LIB_DEB=$(wget -qO- "$QUIRINUX_LIB_URL" | grep -o 'libgimp2.0_[^"]*_amd64.deb' | tail -n1)

if [ -n "$QUIRINUX_LIB_DEB" ]; then
    echo "====> libgimp2.0 encontrado en repo.quirinux.org"
    echo "====> Descargando desde Quirinux..."
    wget -P "$DEST" "$QUIRINUX_LIB_URL$QUIRINUX_LIB_DEB"

    echo "====> Instalando libgimp2.0 desde Quirinux..."
    apt install -y "$DEST/$QUIRINUX_LIB_DEB"
else
    echo "====> libgimp2.0 NO existe en repo.quirinux.org"
    echo "====> Instalando desde repos oficiales..."
    apt update
    apt install -y libgimp2.0
fi

# ==============================================================
# 2) PAQUETES QUIRINUX (EXCEPTO libgimp2.0)
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

echo "====> Descargando paquetes Quirinux..."
for url in "${URLS[@]}"; do
    wget -P "$DEST" "$url"
done

# ==============================================================
# 3) INSTALACIÓN FINAL (ORDEN SEGURO)
# ==============================================================

echo "====> Instalando paquetes..."
apt install -y gimp mplayer
apt install --reinstall -y /tmp/gimp-quirinux/*.deb

# ==============================================================
# FINAL
# ==============================================================

echo ""
echo "==========================================================="
echo " INSTALACIÓN COMPLETA"
echo "==========================================================="
echo " Accede al Configurador Quirinux de GIMP desde:"
echo " >>> Menu Aplicaciones > Configuración > Configurar GIMP"
echo ""
echo "==========================================================="
