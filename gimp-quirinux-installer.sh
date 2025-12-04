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

clear

# Asegurar PATH completo en sistemas tipo Devuan
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

echo "====> Iniciando instalación segura de GIMP Quirinux"

DEST="/tmp/gimp-quirinux"
mkdir -p "$DEST"

# --------------------------------------------------------------
# Verificar wget
# --------------------------------------------------------------
if ! command -v wget >/dev/null 2>&1; then
    echo "====> Instalando wget..."
    apt update
    apt install -y wget
fi

# --------------------------------------------------------------
# INSTALAR libgimp2.0 DESDE REPOS O DESDE QUIRINUX (FALLBACK)
# --------------------------------------------------------------
echo "====> Verificando disponibilidad de libgimp2.0 en repos oficiales..."
apt update

if apt-cache show libgimp2.0 >/dev/null 2>&1; then
    echo "====> libgimp2.0 disponible en repos oficiales. Instalando..."
    apt install -y libgimp2.0
    ORIGEN_LIB="repos"
else
    echo "====> libgimp2.0 NO disponible en repos oficiales."
    echo "====> Descargando desde repo.quirinux..."

    QUIRINUX_LIB_URL="https://repo.quirinux.org/pool/main/g/gimp/libgimp2.0_2.10.35-1+deb12u3_amd64.deb"

    wget -P "$DEST" "$QUIRINUX_LIB_URL" || {
        echo "ERROR: No se pudo descargar libgimp2.0 desde Quirinux."
        exit 1
    }

    echo "====> Instalando libgimp2.0 desde Quirinux..."
    dpkg -i "$DEST"/libgimp2.0_*.deb || true
    apt -f install -y
    ORIGEN_LIB="quirinux"
fi

# --------------------------------------------------------------
# DESCARGAR PAQUETES QUIRINUX (PLUGINS Y CONFIGURADOR)
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
"https://repo.quirinux.org/pool/main/g/gimp-quirinux/gimp-quirinux_6.5.6_all.deb"
)

echo "====> Descargando paquetes Quirinux..."
for url in "${URLS[@]}"; do
    wget -P "$DEST" "$url"
done

# --------------------------------------------------------------
# INSTALAR GIMP SIEMPRE DESDE REPOS OFICIALES
# --------------------------------------------------------------
echo "====> Instalando gimp exclusivamente desde repos oficiales..."

if ! apt install -y gimp; then
    echo "ERROR CRÍTICO:"
    echo " No se pudo instalar gimp desde repos oficiales."
    echo " libgimp2.0 fue instalado desde: $ORIGEN_LIB"
    echo " Existe un conflicto real de versiones."
    echo " El script se detiene para evitar romper el sistema."
    exit 1
fi

# --------------------------------------------------------------
# INSTALAR PAQUETES QUIRINUX CON DPKG
# --------------------------------------------------------------
echo "====> Instalando paquetes Quirinux..."

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
echo ""
echo " Accede al Configurador Quirinux de GIMP desde:"
echo " >>> Menu Aplicaciones > Configuración > Configurar GIMP"
echo ""
echo "==========================================================="
