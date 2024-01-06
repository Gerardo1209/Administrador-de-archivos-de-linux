#!/bin/bash

#------------------------------------------------------------------------------------------------------------
#Declaracion de funciones 
   #Muestra de archivo-------------------------------------(No necesita modificaciones, a exepcion de errores)
      function Mostrar_archivos () {
         local Ret
         local FILE
         #Muestra el dialog de los archivos
         FILE=$(dialog --clear --title "Visor de Archivos" --stdout \
         --cancel-label "Salir"\
         --ok-label "Selecionar" \
         --extra-button \
         --help-button\
         --extra-label "Opciones"\
         --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
         --fselect "$1" 20 80 \ )
         Ret=$? #Obtiene la respuesta del usuario
         if [ "0" -eq "$Ret" ]; then
               #Si la opcion es Seleccionar
               if [ -d "$FILE" ]; then #Si es un directorio muestra la siguiente ruta o deja la actual
                  if [[ "$FILE" == *"/" ]]; then
                     FILE=$(readlink -e "$FILE")
                     Mostrar_archivos "$FILE"   
                  else
                     FILE=$(readlink -e "$FILE")
                     Mostrar_archivos "${FILE}/"
               fi
               elif [ -f "$FILE" ]; then
                  SeleccionOpciones "$FILE" #Si es un archivo muestra el menu de opciones
               else
                  mensajeError_Arch_Dir
               fi
         elif [ "1" -eq "$Ret" ]; then
               #Si la opcion es salir
               dialog --clear --title 'Salida'\
               --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
               --msgbox "Programa finalizado" 6 30 --stdout
               dialog --clear
               clear
               exit
         elif [ "2" -eq "$Ret" ]; then
               dialog --clear --title 'Ayuda' --stdout\
               --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
               --msgbox "Moverse a traves de los submenus <tab>\n\
Cambiar la seleccion <flechas>\n\
Entrar una opcion <enter>\n\
Autocompletar la seleccion <espacio>\n\
Completar la ruta con '/' <enter>\n" 0 0
               Mostrar_archivos "$FILE"
         elif [ "3" -eq "$Ret" ]; then
            SeleccionOpciones "$FILE" #Si selecciona 3 muestra las opciones para carpeta o archivo
         fi
      }

      function SeleccionOpciones () {
         if [[ -r "$1" || -w "$1" || -x "$1" || -O "$1" ]]; then #Si tiene los permisos para realizar alguna operacion
            if [ -d "$1" ]; then
               #Si es una capeta manda al sub menu de carpeta
               siCarpeta "$1"
            elif [ -f "$1" ]; then
               #si es un archivo manda al submenu de archivos
               siArchivo "$1"
            else
               #Si la direccion esta equivocada, regresa al menu con la ruta preestablecida
               mensajeError_Arch_Dir
            fi
         else
            mensajeError_Permisos "$1"
         fi
      }

   #Funciones para llamar a las opciones--------------------------(Donde se llaman funciones para los scripts)
      
      #NOTAS IMPORTANTES
      #"Directorio" siempre sera la ruta que regresa el fselect menos los links "Documentos/../Imagenes/"
      #Solo retorna la liga directa "/Imagenes/"
      #"Carpeta" siempre sera la carpeta que contiene el directorio (ya sea un archivo o otro directorio)
      #"Archivo" es el nombre del archivo que se esta usando
      function siArchivo () {
         local Directorio
         local Carpeta
         local Archivo
         local Seleccion
         local Opcion
         Directorio=$(readlink -e "$1")   #Obtiene el link directo del archivo recibido
         Carpeta=$(dirname "$Directorio") #Obtiene la carpeta que contiene al archivo
         Archivo="${Directorio##*/}"      #Se obtiene el nombre del archivo
         #Usar siempre las variables de archivo, carpeta y directorio si es necesario

         #Muestra el menu
         Opcion=$(dialog --clear --title "Opciones Archivo"\
               --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
               --menu "${Directorio}" 0 0 0\
               1 'Mostrar'\
               2 'Editar'\
               3 'Copiar'\
               4 'Renombrar'\
               5 'Mover'\
               6 'Borrar'\
               7 'Empaquetar' \
               8 'Desempaquetar'\
               9 'Comprimir' \
               10 'Descomprimir' \
               11 'Cambiar permisos'\
               12 'Cambiar propietario'\
               13 'Cambiar grupo'\
               --stdout)
         Seleccion="$?"

         if [ "$Seleccion" -eq 0 ]; then
            #Aqui van las llamadas a los shellscipts
            case "$Opcion" in
               1)
                  if [[ -r "$Directorio" ]]; then #Si tiene los permisos para realizar alguna operacion
                     ./ScriptsFile/mostrar.sh "$Directorio" "$Archivo"
                     Mostrar_archivos "$Directorio"
                  else
                     mensajeError_Permisos "$Directorio"
                  fi
               ;;
               2)
                  if [[ -r "$Directorio" && -w "$Directorio" ]]; then #Si tiene los permisos para realizar alguna operacion
                     ./ScriptsFile/editarArchivos.sh "$Directorio" "$Carpeta" "$Archivo"
                     Mostrar_archivos "$Directorio"
                  else
                     mensajeError_Permisos "$Directorio"
                  fi
               ;;
               3)
                  if [[ -r "$Directorio" ]]; then #Si tiene los permisos para realizar alguna operacion
                     ./ScriptsFile/copiarFile.sh "$Directorio" "$Carpeta" "$Archivo"
                     Mostrar_archivos "$Directorio"
                  else
                     mensajeError_Permisos "$Directorio"
                  fi
               ;;
               4)
                  if [[ -r "$Directorio" && -w "$Directorio" ]]; then #Si tiene los permisos para realizar alguna operacion
                     ./ScriptsFile/renombrarFile.sh "$Directorio"
                  else
                     mensajeError_Permisos "$Directorio"
                  fi 
               ;;
               5)
                  if [[ -r "$Directorio" && -w "$Directorio" ]]; then #Si tiene los permisos para realizar alguna operacion
                     ./ScriptsFile/moverFile.sh "$Directorio" "$Carpeta" "$Archivo"
                  else
                     mensajeError_Permisos "$Directorio"
                  fi  
               ;;
               6)
                  if [[ -r "$Directorio" && -w "$Directorio" ]]; then #Si tiene los permisos para realizar alguna operacion
                     ./ScriptsFile/eliminaFile.sh "$Directorio"
                  else
                     mensajeError_Permisos "$Directorio"
                  fi  
               ;;
               7)
                  if [[ -r "$Directorio" && -w "$Directorio" ]]; then #Si tiene los permisos para realizar alguna operacion
                     ./ScriptsG/empaquetar.sh "$Directorio" "$Archivo" "$Carpeta"
                     Mostrar_archivos "${Carpeta}/"
                  else
                     mensajeError_Permisos "$Directorio"
                  fi
               ;;
               8)
                  if [[ -r "$Directorio" ]]; then #Si tiene los permisos para realizar alguna operacion
                     ./ScriptsG/desempaquetar.sh "$Directorio" "$Carpeta"
                     Mostrar_archivos "${Carpeta}/"
                  else
                     mensajeError_Permisos "$Directorio"
                  fi
               ;;
               9)
                  if [[ -r "$Directorio" && -w "$Directorio" ]]; then #Si tiene los permisos para realizar alguna operacion
                     ./ScriptsG/comprimir.sh "$Directorio" "$Archivo" "$Carpeta"
                     Mostrar_archivos "${Carpeta}/"
                  else
                     mensajeError_Permisos "$Directorio"
                  fi
               ;;
               10)
                  if [[ -r "$Directorio" ]]; then #Si tiene los permisos para realizar alguna operacion
                     ./ScriptsG/descomprimir.sh "$Directorio" "$Carpeta"
                     Mostrar_archivos "${Carpeta}/"
                  else
                     mensajeError_Permisos "$Directorio"
                  fi
               ;;
               11)
                  if [[ -O "$Directorio" || "$(whoami)" == 'root' ]]; then #Si tiene los permisos para realizar alguna operacion
                     ./ScriptsG/cambiarPermisos.sh "$Directorio"
                     Mostrar_archivos "$Directorio"
                  else
                     mensajeError_Permisos "$Directorio"
                  fi
               ;;
               12)
                  if [[ "$(whoami)" == 'root' ]]; then #Si tiene los permisos para realizar alguna operacion
                     ./ScriptsG/cambiarPropietario.sh "$Directorio"
                     Mostrar_archivos "$Directorio"
                  else
                     mensajeError_Root "$Directorio"
                  fi
               ;;
               13)
                  if [[ -O "$Directorio" || "$(whoami)" == 'root' ]]; then #Si tiene los permisos para realizar alguna operacion
                     ./ScriptsG/cambiarGrupo.sh "$Directorio"
                     Mostrar_archivos "$Directorio"
                  else
                     mensajeError_Permisos "$Directorio"
                  fi
               ;;
               *)
                  mensajeError_Opcion
                  Mostrar_archivos "$Directorio"
               ;;
            esac
            Mostrar_archivos "${Carpeta}/"
         else
            #Si selecciono cancelar no hace nada
            Mostrar_archivos "${Carpeta}/"   #Si no sufrio modificaciones, se retornara la ruta completa del archivo
         fi
      
      }

      function siCarpeta () {
         local Directorio
         local Carpeta
         local Seleccion
         local Opcion
         local NomDirectorio
         Directorio=$(readlink -e "$1")   #Obtiene el link directo al directorio que se recibe
         #El directorio no contiene / al final, 
         #por lo que para las funciones como crear 
         #directorio es necesario agregarle el "/" antes
         Carpeta=$(dirname "$Directorio")
         NomDirectorio="${Directorio##*/}"      #Se obtiene el nombre del archivo
         #¡¡Siempre usar la variable directorio o carpeta para pasar parametros entre funciones!!

         #Muestra el menu
         Opcion=$(dialog --clear --title "Opciones Directorio"\
               --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
               --menu "${Directorio}" 0 0 0\
               1 'Copiar'\
               2 'Renombrar'\
               3 'Mover'\
               4 'Crear directorio'\
               5 'Crear archivo'\
               6 'Borrar'\
               7 'Comprimir'\
               8 'Empaquetar'\
               9 'Cambiar permisos'\
               10 'Cambiar propietario'\
               11 'Cambiar grupo'\
               12 'Agregar prefijo a contenido'\
               --stdout)
         Seleccion="$?"
         if [ "$Seleccion" -eq 0 ]; then
            #Aqui van las llamadas a los shellscipts
            case "$Opcion" in
               1)
                  if [[ -r "$Directorio" ]]; then #Si tiene los permisos para realizar alguna operacion
                     ./ScriptsDir/copiarDir.sh "$Directorio"
                  else
                     mensajeError_Permisos "${Directorio}/"
                  fi
               ;;
               2)
                  if [[ -r "$Directorio" && -w "$Directorio" ]]; then #Si tiene los permisos para realizar alguna operacion
                     ./ScriptsDir/renombrarDir.sh "$Directorio"
                  else
                     mensajeError_Permisos "${Directorio}/"
                  fi
               ;;
               3)
                  if [[ -r "$Directorio" && -w "$Directorio" ]]; then #Si tiene los permisos para realizar alguna operacion
                     ./ScriptsDir/moverDir.sh "$Directorio"
                  else
                     mensajeError_Permisos "${Directorio}/"
                  fi
               ;;
               4)
                  if [[ -r "$Directorio" && -w "$Directorio" ]]; then #Si tiene los permisos para realizar alguna operacion
                      ./ScriptsDir/creaDir.sh "$Directorio"
                     Mostrar_archivos "${Directorio}/"
                  else
                     mensajeError_Permisos "${Directorio}/"
                  fi
               ;;
               5)
                  if [[ -r "$Directorio" && -w "$Directorio" ]]; then #Si tiene los permisos para realizar alguna operacion
                     ./ScriptsFile/creaFile.sh "$Directorio"
                     Mostrar_archivos "${Directorio}/"
                  else
                     mensajeError_Permisos "${Directorio}/"
                  fi
               ;;
               6)
                  if [[ -r "$Directorio" && -w "$Directorio" ]]; then #Si tiene los permisos para realizar alguna operacion
                     ./ScriptsDir/eliminaDir.sh "$Directorio"
                  else
                     mensajeError_Permisos "${Directorio}/"
                  fi
               ;;
               7)
                  if [[ -r "$Directorio" && -w "$Directorio" ]]; then 
                  #Si tiene los permisos para realizar alguna operacion
                     ./ScriptsG/comprimir.sh "$Directorio" "$NomDirectorio" "$Carpeta"
                     Mostrar_archivos "${Carpeta}/"
                  else
                     mensajeError_Permisos "${Directorio}/"
                  fi
               ;;
               8)
                  if [[ -r "$Directorio" && -w "$Directorio" ]]; then 
                  #Si tiene los permisos para realizar alguna operacion
                     ./ScriptsG/empaquetar.sh "$Directorio" "$NomDirectorio" "$Carpeta"
                     Mostrar_archivos "${Carpeta}/"
                  else
                     mensajeError_Permisos "${Directorio}/"
                  fi
               ;;
               9)
                  if [[ -O "$Directorio" || $(whoami) == 'root' ]]; then #Si tiene los permisos para realizar alguna operacion
                     ./ScriptsG/cambiarPermisos.sh "$Directorio"
                     Mostrar_archivos "${Directorio}/"
                  else
                     mensajeError_Permisos "${Directorio}/"
                  fi
               ;;
               10)
                  if [[ $(whoami) == 'root' ]]; then #Si tiene los permisos para realizar alguna operacion
                     ./ScriptsG/cambiarPropietario.sh "$Directorio"
                     Mostrar_archivos "${Directorio}/"
                  else
                     mensajeError_Root "${Directorio}/"
                        
                  fi
               ;;
                11)
                  if [[ -O "$Directorio" || $(whoami) == 'root' ]]; then #Si tiene los permisos para realizar alguna operacion
                     ./ScriptsG/cambiarGrupo.sh "$Directorio"
                     Mostrar_archivos "${Directorio}/"
                  else
                     mensajeError_Permisos "${Directorio}/"
                  fi
               ;;
               12)
                  if [[ -r "$Directorio" && -w "$Directorio" ]]; then #Si tiene los permisos para realizar alguna operacion
                     ./ScriptsG/renombrarTodo.sh "$Directorio"
                     Mostrar_archivos "${Directorio}/"
                  else
                     mensajeError_Permisos "${Directorio}/"
                  fi
               ;;
               *)
                  mensajeError_Opcion
                  Mostrar_archivos "${Carpeta}/"
               ;;
            esac
            Mostrar_archivos "${Carpeta}/"
         else
            #Si selecciono cancelar no hace nada
            Mostrar_archivos "${Directorio}/"
         fi
      }
      
   #Funciones para errores---------------------------------(No necesita modificaciones, a exepcion de errores)

      function mensajeError_Arch_Dir () {
         dialog --clear --title 'Error'\
         --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
         --msgbox 'Directorio o archivo no existe' 6 30 --stdout
         Mostrar_archivos "$Filepath"
      }

      function mensajeError_Opcion () {
         dialog --clear --title 'Error'\
         --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
         --msgbox 'La opcion seleccionada no es correcta' 6 30 --stdout
         Mostrar_archivos "$Filepath"
      }

      function mensajeError_Parametros () {
         dialog --clear --title 'Error'\
         --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
         --msgbox 'Error en el paso de parametros' 6 30 --stdout
         Mostrar_archivos "$Filepath"
      }

      function mensajeError_Permisos () {
         dialog --clear --title 'Permisos'\
         --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
         --msgbox 'No tiene permisos para realizar la accion' 6 30 --stdout
         hacerRoot "$1"
      }

      function mensajeError_Root () {
         dialog --clear --title 'Permisos'\
         --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
         --msgbox 'Debe ser root para cambiar el propietario' 6 30 --stdout
         hacerRoot "$1"
      }

      function hacerRoot () {
         dialog --clear --title 'Permisos'\
         --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
         --yesno 'Quiére volverse usuario root?' 6 30 --stdout
         Op=$?
         if [ "$Op" -eq 0 ]; then
            dialog --clear
            clear
            if [ "$(sudo -s ./main.sh "$1" "modo root")" -ne "0" ]; then
               dialog --clear --title "Permisos"\
               --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
               --msgbox "No se pudo volver root" 0 0 --stdout
               Mostrar_archivos "$1"
            else
               dialog --clear --title "Permisos"\
               --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
               --msgbox "Salio de modo super usuario" 0 0 --stdout
               Mostrar_archivos "$1"
            fi
         fi
      }

#Main script comienza aqui----------------------------------(No necesita modificaciones, a exepcion de errores)
   if [ -z "$1" ]; then
      #si la entrada es nula, coloca la ruta predeterminada
      if [ "$(whoami)" == 'root' ]; then
         Filepath="/home/"
      else
         Filepath="/home/$(whoami)/" #Selecciona la carpeta del usuario que este usando el comando
      fi
      Mostrar_archivos "$Filepath" #Envia el directorio como parametro a mostrar archivos
   elif [ -d "$1" ]; then
      if [ "$2" == 'modo root' ]; then
         dialog --clear --title "Permisos"\
         --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
         --msgbox "Accedio a modo super usuario, cuando termine se le retornara al programa donde lo dejo." 0 0 --stdout
         Mostrar_archivos "$1"
      fi
      #Si el archivo es un directorio
      Filepath="$1"
      SeleccionOpciones "$1" #Manda a llamar a mostrar archivos con el mismo directorio que se envio al llamarse
   elif [ -f "$1"  ]; then
      if [ "$2" == 'modo root' ]; then
         dialog --clear --title "Permisos"\
         --backtitle "Proyecto UNIX: Femat Delgado, Mendez Lara, Muñoz Cerda, Prieto Garcia"\
         --msgbox "Accedio a modo super usuario, cuando termine se le retornara al programa donde lo dejo." 0 0 --stdout
         Mostrar_archivos "$1"
      fi
      Filepath="$1"
      SeleccionOpciones "$1" #Si es un archivo el que se manda, llama a la funcion de mostrar opciones
   else
      Filepath="$1"
      Mostrar_archivos /home/ #Si ninguna opcion es valida, simplemente muestra los archivos en /home/
   fi
   dialog --clear
   clear

#Final del script---------------------------------------------------------------------------------------------