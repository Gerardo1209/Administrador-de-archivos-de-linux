#!/bin/bash

#Muestra el contenido de un archivo mediante un msgbox

#$1 Es el archivo que se va a mostrar
#$2 Es el nombre del archivo que se muestra

if [[ -f "$1" && -n "$2" ]]; then
    Info=$(cat -n "$1")    #Le hace cat al archivo y lo guarda en una variable
  if [[ "${Info}" == * ]]; then
    dialog --clear --stdout --title "$2" --ok-label "Continuar"\
    --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
    --msgbox "${Info}" 32 100
    #Saca la informacion del archivo en un msgbox
  else
    dialog --clear --stdout --title "$2"\
    --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
    --msgbox "No se fue posible leer el archivo" 32 100
  fi
fi
