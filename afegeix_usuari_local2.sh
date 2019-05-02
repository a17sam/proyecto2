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
  
	# The first parameter is the user name.
	username=$1
	# The rest of the parameters are for the account comments.
	fulln=${@:2}
	# Generate a password.
	password=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 13 | head -n 1)
	pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
	fullnospaces="$(echo -e "${fulln}" | tr -d '[:space:]')"

	egrep "^$username" /etc/passwd >/dev/null
	if [ $? -eq 0 ]; then
		echo "$username ya existe!"
		exit 2
	else
		# Create the user with the password.
		useradd -m -c $fullnospaces -p $pass $username
		hostname=`hostname`
		# Check to see if the useradd command succeeded.
		# Set the password.
		# Check to see if the passwd command succeeded.
		# Display the username, password, and the host where the user was created.
		[ $? -eq 0 ] && echo -e "\nEl usuario ha sido creado correctamente! \n\nUsuario: \n$username \n\nContraseña: \n$password \n\nHost: \n$hostname\n" || echo "No se ha podido crear el usuario!"
		# Force password change on first login.
		chage -d 0 $username
	fi
else
  echo "Solo el root del sistema puede crear nuevos usuarios"
  exit 3
fi
