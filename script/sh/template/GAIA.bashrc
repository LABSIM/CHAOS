
########
# GAIA #
########

# dynamically check DSI environment first (normally DSI config use "module", sooooo....), then check userhome 

if hash module 2>/dev/null; then

	export GAIA_FOUND_DSI_HOST=true
		
	if [ -f $(find /tmp_user/ -type f -name "*GAIA.conf.sh" 2>/dev/null) ]; then
	
		source $(find /tmp_user/ -type f -name "*GAIA.conf.sh" 2>/dev/null)
	
	else
	
		echo "[GAIA][DSI] Erreur dans la configuration de votre environment de travail... Contactez les administrateurs: Christian S. ou Nawfel K."
	
	fi
	
else 

	export GAIA_FOUND_DSI_HOST=false
	
	if [ -f $(find ~/ -type f -name "*GAIA.conf.sh" 2>/dev/null) ]; then

		source $(find ~/ -type f -name "*GAIA.conf.sh" 2>/dev/null)

	else

		echo "[GAIA] Erreur dans la configuration de votre environment de travail... Contactez les administrateurs: Christian S. ou Nawfel K."

	fi

fi

# EOF
