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
# Verificar si libgimp2.0 existe en los repositorios oficiales
# ==============================================================

echo "====> Verificando si libgimp2.0 está disponible en los repositorios..."

apt update

if apt-cache show libgimp2.0 >/dev/null 2>&1; then
    echo "====> libgimp2.0 encontrado en los repositorios. Instalando desde repo..."
    apt install -y libgimp2.0
    DESCARGAR_LIBGIMP="no"
else
    echo "====> libgimp2.0 NO encontrado en los repositorios."
    echo "====> Se descargará desde repo.quirinux.org"
    DESCARGAR_LIBGIMP="si"
fi

# ==============================================================
# Lista de URLs a descargar (sin libgimp2.0 por defecto)
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

# Si no existe libgimp2.0 en repos, agregarlo a descargas
if [ "$DESCARGAR_LIBGIMP" = "si" ]; then
    URLS+=("https://repo.quirinux.org/pool/main/g/gimp/libgimp2.0_2.10.35-1+deb12u3_amd64.deb")
fi

# ==============================================================
# Descargar paquetes
# ==============================================================

echo "====> Descargando paquetes .deb necesarios..."
for url in "${URLS[@]}"; do
    wget -P "$DEST" "$url"
done

# ==============================================================
# Instalación
# ==============================================================

echo "====> Instalando paquetes..."
apt install gimp --reinstall -y
apt install mplayer --reinstall -y
apt install --reinstall -y /tmp/gimp-quirinux/*.deb

echo ""
echo "==========================================================="
echo " INSTALACIÓN COMPLETA"
echo "==========================================================="
echo " Accede al Configurador Quirinux de GIMP desde:"
echo " >>> Menu Aplicaciones > Configuración > Configurar GIMP"
echo ""
echo "==========================================================="
echo ""
