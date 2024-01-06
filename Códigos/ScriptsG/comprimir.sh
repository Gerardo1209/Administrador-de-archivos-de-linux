#!/bin/bash
#$1 Es el directorio del archivo o carpeta a comprimir
#$2 Es el nombre del directorio o carpeta a comprimir
#$3 Es el directorio que almacena el archivo o directorio
if [[ ( -f "$1" || -d "$1" ) && -n "$2" && -d "$3" ]]; then
    dialog --title 'TAR' --infobox "Comprimiendo datos..." 0 0 --stdout #Mensaje de comprimir datos
    Info=$(tar -czvf "${3}/${2}.tar.gz" -C "$3" "$2") #Intenta comprimir los datos
    if [[ "$?" -ne "0" ]]; then #Comprueba que TAR haya comprimido correctamente los datos
        rm "${3}/${2}.tar.gz" #Si no los comprimio correctamente, entonces elimina el archivo creado y lanza el mensaje
        dialog --title 'Datos no comprimidos'\
        --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
        --msgbox "No se pudo realizar la compresion" 0 0 --stdout
    else #De lo contrario menciona como y donde fue comprimido el archivo
        dialog --title 'Datos comprimidos'\
        --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
        --msgbox "$Info \nEn: ${3}/" 0 0 --stdout
    fi
fi