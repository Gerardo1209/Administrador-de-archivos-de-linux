#!/bin/bash

#$1 Es el archivo comprimido
#$2 Es el directorio donde se descomprimiran los archivos, directorio padre
#Realiza lo mismo que descomprimir, pero la unica diferencia es que no descomprime
#en los parametros para el TAR no se le especifica que debe descomprimir
if [[ -f "$1" && -d "$2" ]]; then
    dialog --title 'TAR' --infobox "Desempaquetando datos..." 0 0 --stdout
    Info=$(tar -xvf "$1" -C "${2}/")
    if [[ "$?" -ne "0" ]]; then
        dialog --title 'Datos no desempaquetados'\
        --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
        --msgbox "No se pudo realizar la desempaquetacion" 0 0 --stdout
    else
        dialog --title 'Datos desempaquetados'\
        --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
        --msgbox "$Info \nEn: ${2}" 0 0 --stdout
    fi
fi