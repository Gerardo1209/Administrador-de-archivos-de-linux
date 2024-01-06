#!/bin/bash
if [ -d "$1" ]; then #Verificamos que la ruta enviada pertenezca a un directorio
    Archivos=$(dialog --clear --title "Selecciono crear Archivos" \
                        --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
                        --inputbox "Ingrese el nombre del archivo" 14 58 \
                        --stdout)
  if [[ "$Archivos" == *"/"* ]]; then #verificamos que el directorio no contenga al final una barra diagonal y muestra el error
    dialog --clar --title 'Error'\
    --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
    --msgbox "El archivo que intento crear contiene '/'" 0 0 --stdout
  else #si no contiene el a diagonal, ejecuta un if donde intenta crear el archivo
    if [ "$(touch "${1}/${Archivos}")" -ne "0" ]; then #Si no es exitoso muestra una pantalla de error
      dialog --clear --title "Crear archivo"\
      --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
      --msgbox "No se pudo crear el archivo" 0 0 --stdout
    fi
  fi
fi

