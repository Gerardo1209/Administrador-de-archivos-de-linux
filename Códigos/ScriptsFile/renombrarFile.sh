#!/bin/bash
if [ -f "$1" ]; then #Si la ruta es un archivo, se ejecuta un inputbox el cual tendrá el nombre nuevo
    Archivos=$(dialog --clear --title "Selecciono Renombrar archivo"\
                        --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
                        --inputbox "Cual será el nuevo nombre para: ${1}" 14 58 \
                        --stdout)
    Carpeta=$(dirname "$1") #Generamos una variable con dirname para solo tener la ruta del archivo
    if [[ "$Archivos" == *"/"* ]]; then #Verificamos que el archivo no contenga una barra diagonal para evitar confunicones 
        dialog --clear --stdout --title "Renombrar archivo"\
        --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
        --msgbox "El nuevo nombre que intenta ingresar contiene '/'" 0 0
    else
        if [ "$(mv "$1" "${Carpeta}/${Archivos}")" -ne "0" ]; then #ejecutamos el comando pero si este no es exitoso muestra un mensaje de error
            dialog --clear --stdout --title "Renombrar archivo"\
            --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
            --msgbox "No se pudo renombrar el archivo" 0 0
        fi
    fi
fi