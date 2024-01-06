#!/bin/bash
#Este Script fue hecho para tener un mejor control sobre archivos generados automáticamente o 
#para Archivos o directorios descargados y así lograr tener un control más organizado
#sobre ciertos archivos en un directorio
#Función solo disponible en los directorios
if [ -d "$1" ]; then #Comprbamos que sea directorio
    Sub=$(dialog --clear --title "Selecciono agregar prefijo" \
          --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
          --inputbox "Ingrese el prefijo para los archivos" 14 58 \
          --stdout)
  if [[ "$Sub" == *"/"* ]]; then #Revisa que el prefijo no contenga diagonales ya que es un caracter especial
    dialog --clear --title --stdout 'Error'\
    --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
    --msgbox "Error, el prefijo que intento agregar contiene '/'" 0 0
  else
    #Si es correcto el prefijo entonces...
    Archs=$(ls "$1") #Obtiene todos los archivos del directorio
    for i in $Archs #Por cada valor obtenido le cambia el nombre
    do
        newNombre="${1}/${Sub}${i}" #Obtiene el nuevo nombre
        archivoOld="${1}/${i}" #Obtiene el nombre antiguo
        mv "$archivoOld" "$newNombre" #Los cambia
    done
  fi
fi