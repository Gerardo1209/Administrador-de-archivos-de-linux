#!/bin/bash

#$1 Es el archivo comprimido
#$2 Es el directorio donde se descomprimiran los archivos, directorio padre
if [[ -f "$1" && -d "$2" ]]; then
    dialog --title 'TAR'\
    --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
    --infobox "Descomprimiendo datos..." 0 0 --stdout
    Info=$(tar -xzvf "$1" -C "${2}/") #Descomprime el archivo que se selecciono en la ruta
    if [[ "$?" -ne "0" ]]; then #Si no se pudo descomprimir el archivo entonces lanza un error
        dialog --title 'Datos no descomprimidos'\
        --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
        --msgbox "No se pudo realizar la descompresion" 0 0 --stdout
    else #Si se pudo descomprimir entonces menciona cuales archivos se descomprimieron
        dialog --title 'Datos descomprimidos'\
        --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
        --msgbox "$Info \n\
        En: ${2}" 0 0 --stdout
    fi
fi