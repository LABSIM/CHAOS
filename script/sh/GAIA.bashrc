
########
# GAIA #
########

# dynamically check DSI environment first (normally DSI configuration use "module" & create a "/tmp_user/$(hostname)/$(whoami)/" localhosted directory , sooooo....), then check 

set GAIA_HOME_DSI_HINT="/tmp_user/$(hostname --short)/$(whoami)"
set GAIA_CONF_FILE=""
set GAIA_FOUND_DSI_HOST=false

if hash module 2>/dev/null; then

	if [ -d "$GAIA_HOME_DSI_HINT" ]; then

		if [ -L "$GAIA_HOME_DSI_HINT" ]; then

			# It is a symlink ! Warning...
			echo "[GAIA][DSI] Avertissement dans la configuration de votre environment de travail ! Votre repertoire DSI sembnle etre un lien symbolique. GAIA sait faire avec mais en cas de probleme, contactez les administrateurs: Christian S. ou Nawfel K."

		fi

		GAIA_FOUND_DSI_HOST=true
		GAIA_CONF_FILE=$(find $GAIA_HOME_DSI_HINT -type f -name "*GAIA.conf.sh" 2>/dev/null)

		if [ -f ${GAIA_CONF_FILE} ]; then

			source ${GAIA_CONF_FILE}

		else

			echo "[GAIA][DSI] Erreur dans la configuration de votre environment de travail... Contactez les administrateurs: Christian S. ou Nawfel K."

		fi


	fi
	
else 

	if [ ! -z $(find ~/ -type f -name "*GAIA.conf.sh" 2>/dev/null) ]; then
		GAIA_CONF_FILE=$(find ~/ -type f -name "*GAIA.conf.sh" 2>/dev/null)
	elif [ ! -z $(find / -type f -name "*GAIA.conf.sh" 2>/dev/null) ]; then
		GAIA_CONF_FILE=$(find / -type f -name "*GAIA.conf.sh" 2>/dev/null)
	else

		echo "[GAIA] Erreur dans la configuration de votre environment de travail... Contactez les administrateurs: Christian S. ou Nawfel K."

	fi
	
	if [ -f ${GAIA_CONF_FILE} ]; then

		source ${GAIA_CONF_FILE}

	fi

fi

unset GAIA_CONF_FILE
unset GAIA_FOUND_DSI_HOST
unset GAIA_HOME_DSI_HINT

# EOF
