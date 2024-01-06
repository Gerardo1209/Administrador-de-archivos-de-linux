#!/bin/bash
#Comprueba que los parametros sean un directorio o archivo
if [ -d "$1" ] || [ -f "$1" ]; then
    #Saca un dialog preguntando al usuario a que usuario quiere transferir la propiedad del archivo
    Usuario=$(dialog --clear --title "Selecciono cambiar propietario de un archivo o directorio" \
                        --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
                        --inputbox "Ingrese el nombre del nuevo propietario" 14 58 \
                        --stdout)
  #Busca en el etc/passwd si existe un usuario con ese nombre, entoences permite transferirlo
  if [ -z "$( cat /etc/passwd | cut -d":" -f1 | grep -w "$Usuario")" ]; then
    #Si no existe entonces lanza un mensaje de error
    dialog --clear --title "Cambiar propietario"\
    --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
    --msgbox "El usuario ingresado no existe" 0 0 --stdout
  else
    #Si existe entoences realiza el cambio y se lo confirma al usuario
    chown "$Usuario" "$1"
    dialog --clear --title "Cambiar propietario"\
    --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
    --msgbox "$1 Se cambio el usuario a: $Usuario" 0 0 --stdout
  fi
fi
#NOTA: Este script sólo funciona con la cuenta de root, ya que no se permite cambiar
#el propietario de un archivo o directorio a cuentas normales