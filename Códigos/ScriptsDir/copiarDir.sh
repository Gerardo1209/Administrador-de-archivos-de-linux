#!/bin/bash
Dir="$1"
function Copiar_Directorios() {
    local Ret
    #Muestra el dialog de los archivos
    FILE=$(dialog --clear --title "Copiar directorio" \
    --cancel-label "Cancelar" \
    --ok-label "Selecionar" \
    --extra-button \
    --extra-label "Confirmar" \
    --help-button\
    --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
    --dselect "$1" 20 80 --stdout ) #dselect es para seleccionar solamente directorios
    Ret=$? #Obtiene la respuesta del usuario
    if [ "0" -eq "$Ret" ]; then
        #Si la opcion es Seleccionar
        if [ -d "$FILE" ]; then #Si es un directorio muestra la siguiente ruta o deja la actual
            if [[ "$FILE" == *"/" ]]; then
                FILE=$(readlink -e "$FILE")
                Copiar_Directorios "$FILE"
            else
                FILE=$(readlink -e "$FILE")
                Copiar_Directorios "${FILE}/"
            fi
        else
            dialog --title 'Error'\
            --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
            --msgbox "La seleccion no es un directorio" 6 30 --stdout
            Copiar_Directorios "$1"
        fi
    elif [ "1" -eq "$Ret" ]; then
        #Si la opcion es salir
        dialog --clear --title 'Mover directorio'\
        --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
        --msgbox "Se cancelo la operacion" 6 40 --stdout
    elif [ "2" -eq "$Ret" ]; then
        #Si selecciona ayuda se muestra
        dialog --clear --title 'Ayuda'\
        --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
        --msgbox "Moverse a traves de los submenus <tab>\n\
Cambiar la seleccion <flechas>\n\
Entrar una opcion <enter>\n\
Autocompletar la seleccion <espacio>\n\
Completar la ruta con '/' <enter>\n"\
        13 45 --stdout
        Copiar_Directorios "$FILE"
    elif [ "3" -eq "$Ret" ]; then
        if [ -d "$FILE" ]; then
            if [ "$(cp -r "$Dir" "$FILE")" -ne "0" ]; then #Aquí es donde se copia el archivo despues de 
                                                           #obtener la ruta de destino
                dialog --title 'Copiar directorio'\
                --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
                --msgbox "No fue posible copiar el directorio" 0 0 --stdout
            else
                dialog --title 'Copiar directorio'\
                --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
                --msgbox "Directorio ${Dir} copiado con exito a: \n ${FILE}" 0 0 --stdout
            fi    
        else
            dialog --title 'Error'\
            --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
            --msgbox "La seleccion no es un directorio" 6 30 --stdout
            Copiar_Directorios "$1"
        fi
    fi
}

if [ -d "$1" ]; then
    Copiar_Directorios "$1"
fi