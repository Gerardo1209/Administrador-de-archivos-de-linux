#!/bin/bash
if [ -d "$1" ] || [ -f "$1" ]; then #Como son Scripts que aplican para casos de directorios o archivos, comprobamos ambas
    #Generamos un inputbox para ingresar el nombre del nuevo grupo que se quiere hacer el cambio
    #el archivo o directorio
    Grupo=$(dialog --clear --title "Selecciono cambiar grupo de un archivo o directorio" \
                        --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
                        --inputbox "Ingrese el nombre del nuevo grupo" 14 58 \
                        --stdout) 
    #Usamos grep para buscar el grupo ingresado en el inputbox.
    #leemos el archivo group en etc donde se guardan los grupos disponibles.
    #con cut leemos solo la primer posición de la división y como los grupos tienen información extra
    #guardada, por lo que la primera posición que es lo que nos importa, la comparamos con lo que tenemos en
    #el archivo
    if [ -z "$( cat /etc/group | cut -d":" -f1 | grep -w "$Grupo")" ]; then
        dialog --clear --title "Cambiar grupo"\
        --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
        --msgbox "El grupo ingresado no existe" 0 0 --stdout
    else
        #Despues comprombamos que el usuario no sea root y que además está en el grupo de destino, ya que si no es ninguno
        #de los dos mencionados, no se puede realizar el comando
        if [[ "$(whoami)" != 'root' && -z "$(groups "$(whoami)" | grep "$Grupo")" ]]; then
            dialog --clear --title "Cambiar grupo"\
            --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
            --msgbox "No se puede cambiar al grupo, ya que no pertenece a el" 0 0 --stdout
        else
        #si es root o pertenece al grupo de destino, hace el cambio de grupo, chown puede hacerlo 
        #cuando se le antepone al nombre ":" con eso chown identifica que es un grupo lo que se está recibiendo
            chown ":${Grupo}" "$1"
            dialog --clear --title "Cambiar grupo"\
            --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
            --msgbox "$1 se cambio el grupo a: $Grupo" 0 0 --stdout
        fi
        
    fi
fi