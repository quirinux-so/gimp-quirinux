#!/bin/bash
# ==============================================================
# Nombre:            install-gimp-quirinux.sh
# Autor:             Charlie Martínez®
# Licencia:          GPL-2
# Utilidad:          Instala el Configurador Quirinux para GIMP
# Distro:            Quirinux, Debian 12 y 13, Devuan 5 y 6
# ==============================================================
# Ejecutar como ROOT (sin sudo)
# ==============================================================
set -e

clear
echo "====> Iniciando instalación segura de GIMP Quirinux"

# --------------------------------------------------------------
# Verificar wget
# --------------------------------------------------------------
if ! command -v wget >/dev/null 2>&1; then
    apt update
    apt install -y wget
fi

DEST="/tmp/gimp-quirinux"
mkdir -p "$DEST"

# --------------------------------------------------------------
# LIMPIEZA FORZADA DE libgimp2.0 EXTERNO (SI EXISTE)
# --------------------------------------------------------------
echo "====> Eliminando versiones externas de libgimp2.0 (si existen)..."
apt remove -y libgimp2.0 || true
apt autoremove -y

# --------------------------------------------------------------
# INSTALAR libgimp2.0 SOLO DESDE REPOS OFICIALES
# --------------------------------------------------------------
echo "====> Instalando libgimp2.0 desde repos oficiales..."
apt update
apt install -y libgimp2.0

# --------------------------------------------------------------
# PAQUETES QUIRINUX (SIN libgimp2.0)
# --------------------------------------------------------------
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
"https://repo.quirinux.org/pool/main/g/gimp-quirinux/gimp-quirinux_6.5.5_all.deb"
)

echo "====> Descargando paquetes Quirinux..."
for url in "${URLS[@]}"; do
    wget -P "$DEST" "$url"
done

# --------------------------------------------------------------
# INSTALAR GIMP Y MPLAYER DESDE REPOS
# --------------------------------------------------------------
echo "====> Instalando gimp y mplayer desde repos..."
apt install -y gimp mplayer

# --------------------------------------------------------------
# INSTALAR PAQUETES QUIRINUX CON DPKG (SIN libgimp2.0)
# --------------------------------------------------------------
echo "====> Instalando paquetes Quirinux con dpkg..."

dpkg -i \
"$DEST"/gimp-gluas_*.deb \
"$DEST"/gimp-gmic_*.deb \
"$DEST"/libgutenprintui2-*.deb \
"$DEST"/gimp-gutenprint_*.deb \
"$DEST"/gimp-lensfun_*.deb \
"$DEST"/libjpeg62-turbo_*.deb \
"$DEST"/gimp-plugin-registry_*.deb \
"$DEST"/gtkam-gimp_*.deb \
"$DEST"/gimp-gap_*.deb \
"$DEST"/gimp-quirinux_*.deb

# --------------------------------------------------------------
# CORREGIR DEPENDENCIAS
# --------------------------------------------------------------
echo "====> Corrigiendo dependencias..."
apt -f install -y

# --------------------------------------------------------------
# FINAL
# --------------------------------------------------------------

echo "==========================================================="
echo " INSTALACIÓN COMPLETA"
echo "==========================================================="
echo " Accede al Configurador Quirinux de GIMP desde:"
echo " >>> Menu Aplicaciones > Configuración > Configurar GIMP"
echo ""
echo "==========================================================="

echo " Accede al Configurador Quirinux de GIMP desde:"
echo " >>> Menu Aplicaciones > Configuración > Configurar GIMP"
echo ""
echo "==========================================================="

