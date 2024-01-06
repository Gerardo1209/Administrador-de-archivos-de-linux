#!/bin/bash

if [[ -f "$1" && -d "$2" && -n "$3" ]]; then #Checa si hay parametros
    Escoger=$(dialog --clear --title 'Editar Archivo'\
                --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
                --radiolist "Seleccione un editor de texto para : ${1}" 0 0 0 \
                1 'Integrado' 1\
                2 'Nano' 2\
                3 'Vi' 3\
                --stdout)
    if [ "$?" -eq 0 ]; then
        if [ "$Escoger" -eq 1 ]; then
            CONTENIDOARCHIVO="$(dialog --clear --title "Editando ${3}"\
            --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
            --editbox "$1" --stdout 40 100)" #Se crea dialog con un editbox que altera el contenido del archivo que se le manda
            Opcion="$?"
            if [[ "${Opcion}" == "0" ]]; then
                touch "${2}/tmp_${3}" #Se crea archivo temporal con el nombre del archivo
                echo "$CONTENIDOARCHIVO">$"${2}/tmp_${3}" #Se envia el contenido del editbox al archivo temporal creada
                mv "${2}/tmp_${3}" "$1" #Se le cambia el nombre al archivo temporal por el nombre del archivo original
                rm "${2}/tmp_${3}"
            else
                dialog --clear --title "Edicion ${3}"\
                --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
                --msgbox "Se cancelo la edicion del archivo" 0 0 --stdout
            fi
        elif [ "$Escoger" -eq 2 ]; then
            nano "$1"
        elif [ "$Escoger" -eq 3 ]; then
            vi "$1"
        fi
    else
        dialog --clear --title "Edicion"\
        --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
        --msgbox "Edicion cancelada" 0 0 --stdout
    fi
fi