#!/bin/bash
#Cambia el nombre del directorio seleccionado, se asegura primero que sea directorio
#despues que no contenga "/" en el nombre para evitar problemas al leer los nombres
if [ -d "$1" ]; then 
    Archivos=$(dialog --clear --title "Selecciono Renombrar directorio" \
                        --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
                        --inputbox "Cual será el nuevo nombre para: ${1}" 14 58 \
                        --stdout)
    Carpeta=$(dirname "$1")
    if [[ "$Archivos" == *"/"* ]]; then
        dialog --clear --stdout --title "Renombrar directorio"\
        --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
        --msgbox "El nuevo nombre que intenta ingresar contiene '/'" 0 0
    else
        #mv tiene una función al usar la misma ruta de destino y origen que cambia el nombre de 
        #el directorio solamente, se conserva sus contenidos
        if [ "$(mv "$1" "${Carpeta}/${Archivos}")" -ne "0" ]; then
            dialog --clear --stdout --title "Renombrar directorio"\
            --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
            --msgbox "No se pudo renombrar el directorio" 0 0
        fi
    fi
fi