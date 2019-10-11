#!/bin/bash 
#
# Version: 1.0
#
######################################################################################
#                                                                                    #
#     SCRIPT: Instalación de SOFE Escritorio Firma Electrónica                       #
#     RUTA: /home/USUARIO/Documentos/sofe                                            #
#     DESCRIPCIÓN: script para instalar y configurar automatizado Sofe               #
#     COPYRIGHT: (C) 2019 Andres MM Alexis <amweb98@gmail.com>                       #
#     LICENCIA: Licencia BSD                                                         #
#     Este programa es software libre. Puede redistribuirlo y/o modificarlo bajo los #
#     términos de la Licencia BSD                                                    #
#                                                                                    #
######################################################################################
#
#  ( Para usar este Script debes ser superusuario ) 
#





# INICIO VERIFICACIÓN DE SISTEMA
echo "Bienvenido a la Configuración de SOFE Escritorio Firma Electrónica"
sleep 1
echo -e "\e[0;34mIngrese Nombre Usuario del Computador de la Siguiente Lista para Continuar\e[0m"
ls /home
echo -e "\n\e[0;34mEscriba el Nombre de Usuario que Utiliza y Presione Enter\e[0m"
read a
distro=$(lsb_release -i | awk '{print $3}')
version=$(lsb_release -r | awk '{print $2}')
echo "El Sistema Actual es $distro"
	if ([ "$distro" = "Canaima" ]) || ([ "$distro" = "Debian" ]); then
		echo  -e "\n\e[0;32mEl Sistema Operativo es el Correcto\e[0m"
	else
		echo  -e "\n\e[1;33mSe instalara pero puede generar error pues el sistema no es Debian o Canaima\e[0m"
	fi
sleep 3
echo "La versión del Sistema es $version"
	if ([ "$version" = "9" ]) || ([ "$version" = "9.1" ]) || ([ "$version" = "9.2" ]) || ([ "$version" = "9.3" ]) || ([ "$version" = "9.4" ]) || ([ "$version" = "9.5" ]) || ([ "$version" = "9.6" ]) || ([ "$version" = "9.7" ]) || ([ "$version" = "9.8" ]) || ([ "$version" = "9.9" ]) || ([ "$version" = "6.0.4" ]) || ([ "$version" = "6" ]); then
		echo  -e "\n\e[0;32mLa Versión del Sistema es Adecuado\e[0m"
	else
		echo  -e "\n\e[1;33mSe instalara pero puede generar error pues la versión del sistema no es apropiado\e[0m"
	fi
sleep 3
echo "Iniciando Proceso"
sleep 3
echo "Descargando Paquetes"

# INSTALACIÓN DE LIBRERIAS
apt-get update
apt-get install libpango1.0-0 -y
apt-get -y install pcscd libusb-0.1-4 pcsc-tools opensc libccid locate

# INSTALACIÓN DE PAQUETES
echo -e "\e[0;34mIdentificando Arquitectura del Computador\e[0m"
sleep 2
uname="$( uname -m )"
echo "Arquitectura $uname"
echo "Instalando Paquetes"
if [ "$uname" = "x86_64" ] ; then
	dpkg -i /home/$a/Documentos/Firma\ sofe/sofe/apps/64/libssl0.9.8_0.9.8o-7_amd64.deb
	dpkg -i /home/$a/Documentos/Firma\ sofe/sofe/apps/64/libhal1_0.5.14-8_amd64.deb
	dpkg -i /home/$a/Documentos/Firma\ sofe/sofe/apps/64/libclassicclient_6.1.0-b07_amd64.deb
elif [ "$uname" = "i686" ] || ["$uname" = "i386" ] ; then
	dpkg -i /home/$a/Documentos/Firma\ sofe/sofe/apps/32/libssl0.9.8_0.9.8o-7_i386.deb
	dpkg -i /home/$a/Documentos/Firma\ sofe/sofe/apps/32/libhal1_0.5.14-3_i386.deb
	dpkg -i /home/$a/Documentos/Firma\ sofe/sofe/apps/32/libclassicclient_6.1.0-b07_i386_fii.deb
else
echo -e "\e[1;33mArquitectura No Soportada No se Puede Completar la Instalación\e[0m"
sleep 5
exit 1
fi
echo "Actualizando" 
apt-get update
apt-get -y install openjdk-8-jdk
apt-get update
sleep 2

# INSTALACIÓN DE SOFE ESCRITORIO
		tar zxvf /home/$a/Documentos/Firma\ sofe/sofe/apps/sofe-escritorio/sofe-escritorio-1.2.0.tar.gz -C /opt
		chown -R $a.$a /opt/sofe-escritorio-1.2.0
		cp /home/$a/Documentos/Firma\ sofe/sofe/apps/sofe-escritorio/sofe-escritorio.desktop /usr/share/applications/
		chmod 644 /usr/share/applications/sofe-escritorio.desktop
echo -e "\e[0;32mIntalación Realizada Exitosamente\e[0m"

#CONFIGURACIÓN DE SOFE ESCRITORIO
echo "Creando Carpetas"
		if [ ! -d /home/$a/Documentos/Sin_Firmar ]; then		
			mkdir /home/$a/Documentos/Sin_Firmar
			chown -R $a.$a /home/$a/Documentos/Sin_Firmar
		fi

		if [ ! -d /home/$a/Documentos/Firmados ]; then		
			mkdir /home/$a/Documentos/Firmados
			chown -R $a.$a /home/$a/Documentos/Firmados		
		fi

		if [ ! -d /home/$a/Documentos/Respaldo ]; then		
			mkdir /home/$a/Documentos/Respaldo
			chown -R $a.$a /home/$a/Documentos/Respaldo		
		fi
echo "¿Desea Eliminar los Archivos que ya no seran utilizados? [s/n]"
read m
case $m in
 	s|S)
	rm -r /home/$a/Documentos/sofe/apps
	rm  /home/$a/Documentos/sofe/install_sofe.sh
	;;
	n|N)
	echo "Se conservaran los Archivos"
	;;
	*)
	echo "opcion no valida, no se efectuaran cambios"
	;;
esac
echo -e "SOFE Escritorio ha sido configurado Exitosamente"			
exit 1

