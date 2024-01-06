#!/usr/bin/bash
#Busca en la dirección enviada y confirma que esta sea un directorio 
#Si lo encuentra y ve que es un directorio lo manda a eliminar
#Marca error si lo elimina y manda un mensaje de error
#Lo mismo si cancela la acción
if [ -d "$1" ]; then
    dialog --clear --title "Selecciono eliminar directorio" \
        --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
        --yesno "Esta a punto de elimnar el directorio ${1}" 14 58 \
        --stdout
    Opcion="$?"
    if [ "$Opcion" -eq "0" ]; then
        if [ "$(rm -r "$1")" -ne "0" ]; then
            dialog --clear --stdout --title "Eliminar directorio"\
            --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
            --msgbox "No fue posible eliminar" 0 0
        else
            dialog --clear --stdout --title "Eliminar directorio"\
            --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
            --msgbox "Eliminado ${1}" 0 0
        fi
    else
        dialog --clear --stdout --title "Eliminar directorio"\
        --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
        --msgbox "Eliminacion cancelada" 0 0
    fi
fi

