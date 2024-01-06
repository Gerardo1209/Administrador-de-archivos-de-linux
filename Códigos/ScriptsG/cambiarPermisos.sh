#!/bin/bash
if [[ -f "$1" || -d "$1" ]]; then
#Verificamos que sea un archivo o un directirio lo que se manda, para después mostrar una checklist
#Con los permisos que se puede otorgar ordenados, para que el usuario los seleccione de una manera más amigable
#Este primer checklist son permisos para el usuario que es propietario del archivo/Directorio
    selUsuario=$(dialog --clear --title 'Cambio de Permisos'\
                --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
                --checklist "Para: Usuario\n ${1}" 0 0 0 \
                '4' 'Lectura' 1\
                '2' 'Escritura' 2\
                '1' 'Ejecucion' 3\
                --stdout)
    Opcion="$?"
    #Despues de hacer eso, comprobamos que dio en aceptar y después de eso recorremos 
    #los numeros que selecconó el usuario y los suma para así obtener el valor octal del permiso
    if [ "$Opcion" -eq "0" ]; then
        NumUsuario=0
        for i in ${selUsuario}; do
            NumUsuario="$(( "$NumUsuario" + "$i" ))"
        done
        #Continuamos y repetimos los pasos pero ahora para los permisos de los grupos
        #El grupo tiene que ser el mismo que el del propietario (Se puede modificar)
        selGrupo=$(dialog --clear --title 'Cambio de Permisos'\
                --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
                --checklist "Para: Grupo\n ${1}" 0 0 0 \
                '4' 'Lectura' 1\
                '2' 'Escritura' 2\
                '1' 'Ejecucion' 3\
                --stdout)
        Opcion="$?"
        if [ "$Opcion" -eq "0" ]; then
            NumGrupo=0
            for i in ${selGrupo}; do
                    NumGrupo="$(( "$NumGrupo" + "$i" ))"
            done
            #finalmente volvemos a hacer lo mismo pero con los últimos permisos que son para los usuarios normales
            #los que no están ni en el grupo del propietario ni son el propietario
            selOtros=$(dialog --clear --title 'Cambio de Permisos'\
                --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
                --checklist "Para: Otros\n ${1}" 0 0 0 \
                '4' 'Lectura' 1\
                '2' 'Escritura' 2\
                '1' 'Ejecucion' 3\
                --stdout)
            Opcion="$?"
            if [ "$Opcion" -eq "0" ]; then
                NumOtros=0
                for i in ${selOtros}; do
                    NumOtros="$(( "$NumOtros" + "$i" ))"
                done
                #concatemamos los numero obtenidos 
                Permisos="${NumUsuario}${NumGrupo}${NumOtros}"
                #Cambiamos los permisos del archivo/Directorio
                #si por alguna razón falla, manda un mensaje de error
                #NOTA este codigo solo puede ser usado cuando eres root o el propietario del archivo
#Todo este código es para lanzar errores en caso que se cancele la operación o de un error el cambio de permisos
                if [ "$(chmod "$Permisos" "$1")" -ne "0" ]; then
                    dialog --clear --title 'Cambio de permisos'\
                    --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
                    --msgbox "No se pudieron cambiar los permisos" 0 0 --stdout
                else
                    dialog --clear --title 'Cambio de permisos'\
                    --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
                    --msgbox "Se cambiaron los permisos a: ${Permisos}\n En: ${1}" 0 0 --stdout
                fi
            else
                dialog --clear --title 'Cambio de Permisos'\
                --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
                --msgbox "Operacion cancelada" 0 0 --stdout
            fi
        else
            dialog --clear --title 'Cambio de Permisos'\
            --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
            --msgbox "Operacion cancelada" 0 0 --stdout
        fi
    else
        dialog --clear --title 'Cambio de Permisos'\
        --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
        --msgbox "Operacion cancelada" 0 0 --stdout
    fi
fi

    
