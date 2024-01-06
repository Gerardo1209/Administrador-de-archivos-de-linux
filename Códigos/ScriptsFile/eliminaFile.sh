#!/usr/bin/bash
if [ -f "$1" ]; then #Verificamos que la ruta mandada sea un archivo, en caso de serlo manda un mensaje 
                     #de confirmación si quiere eliminarlo
    dialog --clear --title "Selecciono eliminar archivo" \
                        --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
                        --yesno "Esta a punto de elimnar el archivo ${1}" 14 58 \
                        --stdout
    Opcion=$?
    if [ "$Opcion" -eq 0 ]; then # si la respuesta es positiva, regresa un 0 y elimina el archivo
        if [ "$(rm "$1")" -ne "0" ]; then #Corremos el comando y si no es exitoso mandamos un mensaje de error
            dialog --clear --title "Eliminar Archivo"\
            --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
            --msgbox "No se pudo eliminar el archivo" 0 0 --stdout
        fi
    else #si la respuesta es cancelar, se regresa un 1 y mandamos un mensaje de cancelación
        dialog --clear --title "Eliminar Archivo"\
        --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
        --msgbox "Eliminacion cancelada" 0 0 --stdout
    fi
fi