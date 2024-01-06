#!/bin/bash

function Buscar_directorio () {
    local Ret
    local FILE
    #Muestra el dialog de los archivos
    FILE=$(dialog --clear --title "Copiar archivo" --stdout \
    --cancel-label "Cancelar"\
    --ok-label "Selecionar" \
    --extra-button\
    --help-button\
    --extra-label "Confirmar"\
    --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
    --dselect "$1" 20 80 )
    Ret=$? #Obtiene la respuesta del usuario
    if [ "0" -eq "$Ret" ]; then
        #Si la opcion es Seleccionar
        if [ -d "$FILE" ]; then #Si es un directorio muestra la siguiente ruta o deja la actual
            if [[ "$FILE" == *"/" ]]; then
                FILE=$(readlink -e "$FILE") 
                Buscar_directorio "$FILE"
            else
                FILE=$(readlink -e "$FILE")
                Buscar_directorio "${FILE}/"
            fi
        else
            #Si no es un directorio marca error
            dialog --title 'Error'\
            --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
            --msgbox "La seleccion no es un directorio" 6 30 --stdout
            Buscar_directorio "$1"
        fi
    elif [ "1" -eq "$Ret" ]; then
        #Si cancelo la operacion, se lo informa al usuario y regresa vacio
        echo ''
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
        Buscar_directorio "$FILE"
    elif [ "3" -eq "$Ret" ]; then
      #Si selecciona 3, comprueba que sea un directorio
      if [ -d "$FILE" ]; then
        echo "$FILE"
      else
        dialog --title 'Error'\
        --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
        --msgbox "La seleccion no es un directorio" 6 30 --stdout
        Buscar_directorio "$1"
      fi
    fi
}

#$1 archivo a mover (Directorio)
#$2 Directorio de inicio (Carpeta)
#$3 Nombre del archivo
if [[ -f "$1" && -d "$2" && -n "$3" ]]; then
    #Manda a seleccionar el directorio al que se quiere copiar el archivo
    carpetaMover="$(Buscar_directorio "$2")"
    #Una vez obtenida la ruta
    if [ -d "$carpetaMover" ]; then
        #Comprueba que exista la ruta
        if [ "$(cp "$1" "$carpetaMover")" -ne "0" ]; then #Intenta copiar el archivo, si da error
            #Lanza mensaje de error
            dialog --clear --title 'Copiar archivo'\
            --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
            --msgbox "No se pudo copiar el archivo" 0 0 --stdout
        else
            #En caso que se complete, le confirma la accion al usuario
            dialog --clear --title 'Copiar archivo'\
            --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
            --msgbox "Se copio correctamente ${3} a:\n ${carpetaMover}" 0 0 --stdout
        fi
    else #Si se cancela la operacion lanza el mensaje de cancelado
        dialog --clear --title 'Copiar archivo'\
        --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
        --msgbox "Se cancelo la operacion" 0 0 --stdout
    fi
fi