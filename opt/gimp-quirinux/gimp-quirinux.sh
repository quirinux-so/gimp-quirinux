#!/bin/bash

# Nombre:	gimp-quirinux.sh
# Autor:	Charlie Martínez® <cmartinez@quirinux.org>
# Licencia:	https://www.gnu.org/licenses/gpl-3.0.txt
# Descripción:	Complento que permite definir el aspecto de GIMP y revertir los cambios.
# Versión:	1.00

# Generando el menú gráfico con Zenity:

opc=$(zenity --width=500 --height=220 --title=gimp-quirinux --entry --text="  
              ¡Ahora puedes modificar el aspecto y/o atajos
              de teclado de GIMP, las veces que quieras!.

              Introduce una opción: 

	      1) Usar iconos y atajos de Photoshop
	      2) Usar iconos y atajos de GIMP	
	      3) Usar iconos de Photoshop y atajos de GIMP
              4) Usar iconos de GIMP y atajos de Photoshop
              5) Salir

"
)

case $opc in

# PHOTOSHOP ICONOS Y ATAJOS

"1") 

(

echo "# Configurando como Photoshop"; sleep 1s

sudo chmod 755 -R /home/

sudo rm -rf /home/*/.config/GIMP
sudo rm -rf /root/.config/GIMP 
sudo rm -rf /usr/share/gimp 
sudo rm -rf /etc/skel/.config/GIMP 

for usuarios in /home/*; do sudo yes | sudo cp -r /opt/gimp-quirinux/gimp-shop/.config $usuarios; done

sudo yes | sudo cp -rf /opt/gimp-quirinux/gimp-shop/.config /root/ 
sudo yes | sudo cp -rf /opt/gimp-quirinux/gimp-shop/.config /etc/skel/ 
sudo yes | sudo cp -rf /opt/gimp-quirinux/gimp-shop/usr/share /usr/

sudo chmod 755 -R /home/

echo "# GIMP se configuró con los íconos y atajos de Photoshop."; sleep 3s
)|

zenity --progress --pulsate 

title="Quirinux"
percentage=0


;;

# GIMP ICONOS Y ATAJOS

"2") 

(

echo "# Configurando como GIMP"; sleep 1s

sudo chmod 755 -R /home/
sudo rm -rf /home/*/.config/GIMP
sudo rm -rf /root/.config/GIMP
sudo rm -rf /usr/share/gimp
sudo rm -rf /et/skel/.config/GIMP
for usuarios in /home/*; do sudo yes | sudo cp -r /opt/gimp-quirinux/gimp-original-full/.config $usuarios; done
sudo yes | sudo cp -r /opt/gimp-quirinux/gimp-original-full/.config /root/
sudo yes | sudo cp -r /opt/gimp-quirinux/gimp-original-full/.config /etc/skel/.config/
sudo yes | sudo cp -r /opt/gimp-quirinux/gimp-original-full/usr/share /usr/
sudo chmod 755 -R /home/

echo "# GIMP se configuró con sus propios íconos y atajos de teclado."; sleep 1s

)|

zenity --progress --pulsate 

title="Quirinux"
percentage=0

;;


# ICONOS DE PHOTOSHOP Y ATAJOS DE GIMP

"3") 
(

echo "# Configurando íconos Photoshop y atajos de GIMP"; sleep 1s

sudo chmod 755 -R /home/ 
sudo rm -rf /home/*/.config/GIMP
sudo rm -rf /root/.config/GIMP 
sudo rm -rf /usr/share/gimp 
sudo rm -rf /etc/skel/.config/GIMP 
for usuarios in /home/*; do sudo yes | sudo cp -r /opt/gimp-quirinux/gimp-shop/.config $usuarios; done 
sudo yes | sudo cp -r /opt/gimp-quirinux/gimp-shop/.config/* /root/.config/ 
sudo yes | sudo cp -r /opt/gimp-quirinux/gimp-shop/.config/* /etc/skel/.config/ 
sudo yes | sudo cp -r /opt/gimp-quirinux/gimp-shop/usr/share /usr/
sudo chmod 755 -R /home/
for usuarios in /home/*; do sudo yes | sudo cp -r /opt/gimp-quirinux/gimp-original-rc/.config $usuarios; done
sudo yes | sudo cp -r /opt/gimp-quirinux/gimp-original-rc/.config /root/
sudo yes | sudo cp -r /opt/gimp-quirinux/gimp-original-rc/.config /etc/skel/
sudo chmod 755 -R /home/

echo "# GIMP se configuró con los íconos de Photoshop, pero con sus propios atajos de teclado."; sleep 1s
)|

zenity --progress --pulsate 

title="Quirinux"
percentage=0


;;

# ICONOS DE GIMP Y ATAJOS DE PHOTOSHOP

"4") 
(

echo "# Configurando íconos GIMP y atajos Photoshop"; sleep 1s

sudo chmod 755 -R /home/
sudo rm -rf /home/*/.config/GIMP
sudo rm -rf /root/.config/GIMP
sudo rm -rf /usr/share/gimp
sudo rm -rf /et/skel/.config/GIMP
for usuarios in /home/*; do sudo yes | cp  -r /opt/gimp-quirinux/gimp-original-full/.config $usuarios; done
sudo yes | sudo cp -r /opt/gimp-quirinux/gimp-original-full/.config /root/
sudo yes | sudo cp -r /opt/gimp-quirinux/gimp-original-full/.config /etc/skel/
sudo yes | sudo cp -r /opt/gimp-quirinux/gimp-original-full/usr/share /usr/
sudo chmod 755 -R /home/
for usuarios in /home/*; do sudo yes | cp  -r /opt/gimp-quirinux/gimp-shop-rc/.config $usuarios; done
sudo yes | sudo cp -r /opt/gimp-quirinux/gimp-shop-rc/.config /root/
sudo yes | sudo cp -r /opt/gimp-quirinux/gimp-shop-rc/.config /etc/skel/
sudo chmod 755 -R /home/

echo "# GIMP se configuró con sus propios íconos, pero con los atajos de teclado de Photoshop."; sleep 1s

)|

zenity --progress --pulsate 

title="Quirinux"
percentage=0


;;


"5") 

	exit 0
;; 

esac


