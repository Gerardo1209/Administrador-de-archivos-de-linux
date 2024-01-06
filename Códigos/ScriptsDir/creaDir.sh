#!/bin/bash
#Generamos un directorio desde la ruta especificada
#En el inputbox se obtiene el nombre para generar el directorio
#el segundo if comprueba que no marqué error al crearlo y si no manda un mensaje de error
if [ -d "$1" ]; then
    Directorios=$(dialog --clear --title "Selecciono crear directorio" \
                       --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
                       --inputbox "Ingrese el nombre del directorio" 14 58 \
                       --stdout)
    if [ "$(mkdir "${1}/${Directorios}")" -ne "0" ]; then
        dialog --clear --title "Crear Directorio"\
        --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
        --msgbox "No se pudo crear el directorio" 0 0 --stdout
    fi
fi

