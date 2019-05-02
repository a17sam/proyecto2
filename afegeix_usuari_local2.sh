#!/bin/bash

# Make sure the script is being executed with superuser privileges.
if [ $(id -u) -eq 0 ]; then

# If the user doesn't supply at least one argument, then give them help.
	if [ $# -lt 1 ]; then
	echo  "Error: No se ha introducido un usuario"
	echo "Uso del programa: $0 usuario nombre completo"
	exit 1
	fi
	if [ $# -lt 2 ]; then
	echo  "Error: No se ha introducido el nombre completo del usuario"
	echo "Uso del programa: $0 usuario nombre completo"
	exit 1
	fi
