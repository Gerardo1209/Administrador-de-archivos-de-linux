#!/bin/bash
Dir="$1"
function Mover_Directorios() {
    local Ret
    #Muestra el dialog de los archivos
    FILE=$(dialog --clear --title "Mover directorio" --stdout \
    --cancel-label "Cancelar" \
    --ok-label "Selecionar" \
    --extra-button \
    --extra-label "Confirmar" \
    --help-button\
    --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
    --dselect "$1" 20 80 \ )
    Ret=$? #Obtiene la respuesta del usuario
    if [ "0" -eq "$Ret" ]; then
        #Si la opcion es Seleccionar
        if [ -d "$FILE" ]; then #Si es un directorio muestra la siguiente ruta o deja la actual
            if [[ "$FILE" == *"/" ]]; then
                FILE=$(readlink -e "$FILE")
                Mover_Directorios "$FILE"
            else
                FILE=$(readlink -e "$FILE")
                Mover_Directorios "${FILE}/"
            fi
        else
            dialog --title 'Error'\
            --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
            --msgbox "La seleccion no es un directorio" 6 30 --stdout
            Mover_Directorios "$1"
        fi
    elif [ "1" -eq "$Ret" ]; then
        #Si la opcion es salir
        dialog --clear --title 'Mover directorio'\
        --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
        --msgbox "Se cancelo la operacion" 6 40 --stdout
    elif [ "2" -eq "$Ret" ]; then
        #Si selecciona ayuda se muestra la ayuda
        dialog --clear --title 'Ayuda'\
        --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
        --msgbox "Moverse a traves de los submenus <tab>\n\
Cambiar la seleccion <flechas>\n\
Entrar una opcion <enter>\n\
Autocompletar la seleccion <espacio>\n\
Completar la ruta con '/' <enter>\n"\
        13 45 --stdout
        Mover_Directorios "$FILE"
    elif [ "3" -eq "$Ret" ]; then
        #Si selecciona confirmar entonces realizará el proceso de mover
        if [ -d "$FILE" ]; then
            #Si es un directorio entonces intenta realizar el procedimiento
            if [ "$(mv "$Dir" "$FILE")" -ne "0" ]; then
                #Si da error se menciona que hubo un error
                dialog --title 'Mover directorio'\
                --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
                --msgbox "No fue posible mover el directorio" 0 0 --stdout
            else
                #Si la operacion tuvo exito saca un mensaje de que se realizo la operación
                dialog --title 'Mover directorio'\
                --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
                --msgbox "Directorio ${Dir} movido con exito a: \n ${FILE}" 0 0 --stdout
            fi
        else
            #Si no se selecciono una carpeta lanzara un error de directorio
            dialog --title 'Error'\
            --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
            --msgbox "La seleccion no es un directorio" 6 30 --stdout
            Mover_Directorios "$1"
        fi
    fi
}

if [ -d "$1" ]; then
    Mover_Directorios "$1"
fi
#home/Documentos/ home/Documentos/Documentos