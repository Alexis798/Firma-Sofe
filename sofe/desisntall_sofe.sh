#!/bin/bash 
#
# Version: 1.0
#
######################################################################################
#                                                                                    #
#     SCRIPT: Desintalación de SOFE Escritorio Firma Electrónica                     #
#     RUTA: /home/USUARIO/Documentos/sofe                                            #
#     DESCRIPCIÓN: script para desintalar SOFE Escritorio y directorios asociados    #
#     COPYRIGHT: (C) 2019 Andres MM Alexis <andres.alexi07@gmail.com>                #
#     LICENCIA: Licencia BSD                                                         #
#     Este programa es software libre. Puede redistribuirlo y/o modificarlo bajo los #
#     términos de la Licencia BSD                                                    #
#                                                                                    #
######################################################################################
#
#  ( Para usar este Script debes ser superusuario ) 
#


echo -e "\e[0;34mIngrese Nombre Usuario del Computador de la Siguiente Lista para Continuar\e[0m"
ls /home
echo -e "\n\e[0;34mEscriba el Nombre de Usuario que Utiliza y Presione Enter\e[0m"
read a
apt-get -y purge pcscd pcsc-tools opensc libccid locate libssl0.9.8 libclassicclient libhal1
apt-get -y purge openjdk-8-jdk openjdk-8-jre openjdk-8-jre-headless
apt-get -y autoremove

echo "Eliminar SOFE"
sleep 1
rm -R /opt/sofe-escritorio-1.2.0/

echo "Eliminar icono de SOFE"
sleep 1
rm -R /usr/share/applications/sofe-escritorio.desktop

echo "¿Desea Eliminar las Carpetas de SOFE Permanentemente? [S/n]"
read m
case $m in
 	s|S)
	rm -r /home/$a/Documentos/Sin_Firmar
	rm -r /home/$a/Documentos/Firmados
	rm -r /home/$a/Documentos/Respaldo
	;;
	n|N)
	echo "Se conservaran las Carpetas"
	;;
	*)
	echo "opcion no valida, no se efectuaran cambios"
	;;
esac
rm -r /home/$a/Documentos/sofe
echo "SOFE ha sido desintalado correctamente"
