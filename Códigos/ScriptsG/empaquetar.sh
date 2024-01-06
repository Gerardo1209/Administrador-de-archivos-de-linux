#!/bin/bash
#$1 Es el directorio del archivo o carpeta a comprimir
#$2 Es el nombre del directorio o carpeta a comprimir
#$3 Es el directorio que almacena el archivo o directorio
#Realiza lo mismo que comprimir pero no se le especifica
#a TAR que debe comprimirlo, simplemente lo junta
if [[ ( -f "$1" || -d "$1" ) && -n "$2" && -d "$3" ]]; then
    dialog --title 'TAR' --infobox "Empaquetando datos..." 0 0 --stdout
    Info=$(tar -cvf "${3}/${2}.tar" -C "$3" "$2")
    if [[ "$?" -ne "0" ]]; then
        rm "${3}/${2}.tar"
        dialog --title 'Datos no empaquetados'\
        --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
        --msgbox "No se pudo realizar el empaquetamiento" 0 0 --stdout
    else
        dialog --title 'Datos empaquetados'\
        --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
        --msgbox "$Info \n \
        En: ${3}/" 0 0 --stdout
    fi
fi