.PHONY: all

all: dialog sudo main.sh mensajefinal

dialog:
ifeq (, $(shell which dialog))
	$(error "No se ha encontrado dialog, instalelo con su gestor de paquetes")
else
	@echo "Dialog encontrado en el sistema"
endif

sudo:
ifeq (, $(shell which sudo))
	$(error "No se ha encontrado sudo, instalelo con su gestor de paquetes")
else
	@echo "Sudo encontrado en el sistema"
endif

mensajefinal:
	@echo "Configuraciones terminadas, ahora puede ejecutar './main.sh'"

main.sh: cambiarGrupo.sh cambiarPermisos.sh cambiarPropietario.sh comprimir.sh descomprimir.sh empaquetar.sh desempaquetar.sh renombrarTodo.sh copiarFile.sh creaFile.sh editarArchivos.sh eliminaFile.sh mostrar.sh moverFile.sh renombrarFile.sh copiarDir.sh creaDir.sh eliminaDir.sh moverDir.sh renombrarDir.sh
ifneq (,$(wildcard ./main.sh))
	$(shell chmod 755 main.sh)
else
	$(error "No se encontro main.sh")
endif

cambiarGrupo.sh:
ifneq (,$(wildcard ./ScriptsG/cambiarGrupo.sh))
	$(shell chmod 755 ScriptsG/cambiarGrupo.sh)
else
	$(error "No se encontro ScriptsG/cambiarGrupo.sh")
endif
	

cambiarPermisos.sh:
ifneq (,$(wildcard ./ScriptsG/cambiarPermisos.sh))
	$(shell chmod 755 ScriptsG/cambiarPermisos.sh)
else
	$(error "No se enocntro ScriptsG/cambiarPermisos.sh")
endif

cambiarPropietario.sh:
ifneq (,$(wildcard ./ScriptsG/cambiarPropietario.sh))
	$(shell chmod 755 ScriptsG/cambiarPropietario.sh)
else
	$(error "No se enocntro ScriptsG/cambiarPropietario.sh")
endif
	
comprimir.sh:
ifneq (,$(wildcard ./ScriptsG/comprimir.sh))
	$(shell chmod 755 ScriptsG/comprimir.sh)
else
	$(error "No se enocntro ScriptsG/comprimir.sh")
endif
	
descomprimir.sh:
ifneq (,$(wildcard ./ScriptsG/descomprimir.sh))
	$(shell chmod 755 ScriptsG/descomprimir.sh)
else
	$(error "No se enocntro ScriptsG/descomprimir.sh")
endif
	
empaquetar.sh:
ifneq (,$(wildcard ./ScriptsG/empaquetar.sh))
	$(shell chmod 755 ScriptsG/empaquetar.sh)
else
	$(error "No se enocntro ScriptsG/empaquetar.sh")
endif
	
desempaquetar.sh:
ifneq (,$(wildcard ./ScriptsG/desempaquetar.sh))
	$(shell chmod 755 ScriptsG/desempaquetar.sh)
else
	$(error "No se enocntro ScriptsG/desempaquetar.sh")
endif
	
renombrarTodo.sh:
ifneq (,$(wildcard ./ScriptsG/renombrarTodo.sh))
	$(shell chmod 755 ScriptsG/renombrarTodo.sh)
else
	$(error "No se enocntro ScriptsG/renombrarTodo.sh")
endif
	

copiarFile.sh:
ifneq (,$(wildcard ./ScriptsFile/copiarFile.sh))
	$(shell chmod 755 ScriptsFile/copiarFile.sh)
else
	$(error "No se enocntro ScriptsFile/copiarFile.sh")
endif	

creaFile.sh:
ifneq (,$(wildcard ./ScriptsFile/creaFile.sh))
	$(shell chmod 755 ScriptsFile/creaFile.sh)
else
	$(error "No se enocntro ScriptsFile/creaFile.sh")
endif	
	
editarArchivos.sh:
ifneq (,$(wildcard ./ScriptsFile/editarArchivos.sh))
	$(shell chmod 755 ScriptsFile/editarArchivos.sh)
else
	$(error "No se enocntro ScriptsFile/editarArchivos.sh")
endif	
	
eliminaFile.sh:
ifneq (,$(wildcard ./ScriptsFile/eliminaFile.sh))
	$(shell chmod 755 ScriptsFile/eliminaFile.sh)
else
	$(error "No se enocntro ScriptsFile/eliminaFile.sh")
endif	
	
mostrar.sh:
ifneq (,$(wildcard ./ScriptsFile/mostrar.sh))
	$(shell chmod 755 ScriptsFile/mostrar.sh)
else
	$(error "No se enocntro ScriptsFile/mostrar.sh")
endif	
	
moverFile.sh:
ifneq (,$(wildcard ./ScriptsFile/moverFile.sh))
	$(shell chmod 755 ScriptsFile/moverFile.sh)
else
	$(error "No se enocntro ScriptsFile/moverFile.sh")
endif	
	
renombrarFile.sh:
ifneq (,$(wildcard ./ScriptsFile/renombrarFile.sh))
	$(shell chmod 755 ScriptsFile/renombrarFile.sh)
else
	$(error "No se enocntro ScriptsFile/renombrarFile.sh")
endif	
	
copiarDir.sh:
ifneq (,$(wildcard ./ScriptsDir/copiarDir.sh))
	$(shell chmod 755 ScriptsDir/copiarDir.sh)
else
	$(error "No se enocntro ScriptsDir/copiarDir.sh")
endif	

creaDir.sh:
ifneq (,$(wildcard ./ScriptsDir/creaDir.sh))
	$(shell chmod 755 ScriptsDir/creaDir.sh)
else
	$(error "No se enocntro ScriptsDir/creaDir.sh")
endif
	
eliminaDir.sh:
ifneq (,$(wildcard ./ScriptsDir/eliminaDir.sh))
	$(shell chmod 755 ScriptsDir/eliminaDir.sh)
else
	$(error "No se enocntro ScriptsDir/eliminaDir.sh")
endif
	

moverDir.sh:
ifneq (,$(wildcard ./ScriptsDir/moverDir.sh))
	$(shell chmod 755 ScriptsDir/moverDir.sh)
else
	$(error "No se enocntro ScriptsDir/moverDir.sh")
endif

renombrarDir.sh:
ifneq (,$(wildcard ./ScriptsDir/renombrarDir.sh))
	$(shell chmod 755 ScriptsDir/renombrarDir.sh)
else
	$(error "No se enocntro ScriptsDir/renombrarDir.sh")
endif