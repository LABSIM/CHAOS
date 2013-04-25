#!/bin/bash
#
# Switch Environment Script
#
# L'objectif de ce scipt est de permettre la diffusion d'un environment de travail sur
# l'ensemble du réseau configuré dans le fichier networkMap.conf.sh
#
# (Valentines's Day)
# 14/02/2012 - Kinani Nawfel
#
#################################################

# ============================================================== #
# 							BASIC VARIABLES DECLARATION							#
# ============================================================== #
argument="$1"

major_version=1
minor_version=0
patch_version=40    

script_version="v.${major_version}.${minor_version}.${patch_version}"

rsh_login=$(whoami)

root_directory=$(readlink -f "${PWD}/../")

link_base_name=${rsh_login}
link_path_directory="/home/${rsh_login}/."

env_decoration="_env_file_lst"
env_file_decoration=".conf.sh"
env_path_directory="${root_directory}/env/"


declare -a env_file_lst

# ============================================================== #
# 							BASIC FUNCTIONS DECLARATION							#
# ============================================================== #

###
# Comme l'indique son nom, son but est d'afficher un message utilisateur su l'utilisation du script
function info_printing ()
{
	echo
	echo "======================================================"
	echo " 	    Switch Environment Script ${script_version}"
	echo "======================================================"
	echo
	echo " > L'objectif de ce script est de permettre la"
	echo " diffusion d'un environment de travail sur"
	echo " l'ensemble du réseau configuré dans le fichier"
	echo " ${root_directory}/conf/networkMap.conf.sh"
	echo
	echo " > Les différentes configurations des environments"
	echo " de travail sont répertoriées sous"
	echo " ${env_path_directory}* et doivent adopter "
	echo " la synthaxe {[CONFIGNAME].conf.sh}"
	echo
	echo " ===[ATTENTION]"
	echo 
	echo " > si aucune machine n'est definie dans le fichier "
	echo "   de configuration du réseau, la diffusion sera "
	echo "   locale seulement. "
	echo
	echo " > le script rebootera la/les machine(s) à configurer"
	echo
	echo " ===[/ATTENTION]"
	echo
	echo "======================================================"
	echo
	echo "Usage:"
	echo "  switchenv ARG | OPTION"
	echo
	echo "ARG:"
	echo "  - Le type de l'environment de travail a"
	echo "  diffuser, ex: ELIPSDEV"
	echo
	echo "OPTION :"
	echo 
	echo " --help , -h 		Afiche cette page "
	echo " --version , -v 	Affiche la version courante "
	echo
	echo "======================================================"
	echo "		   LabSim - 16/02/2012 - Nawfel Kinani"
	echo "======================================================"
	echo 
	
	exit 0
}

###
# On check l'existance du fichier de mapping et on le source
function check_ntwk_conf () 
{
	if [ -f "${root_directory}/conf/networkMap.conf.sh" ];  then
		. "${root_directory}/conf/networkMap.conf.sh"
		echo ">> Fichier de configuration du réseau : trouvé"
	else
		echo; echo "Aucun fichier de mapping du résau trouvé ! Abandon de la diffusion ..."; echo
		exit 1
	fi
	internal_ntwk=("${NTWK[@]}")	# On récupère une copie de travail interne
}

###
# On check si la liste est nulle
function check_ntwk_sz () 
{
	if ((${#internal_ntwk[@]} == 0 )); then
		echo "Aucun element trouvé dans la liste de configuration du réseau, cf. networkMap.conf.sh ! diffusion locale seulement ...";
	else 
		echo ">> ${#internal_ntwk[@]} ordinateur(s) distant(s) trouvé(s)"
	fi
	internal_ntwk_sz=${#internal_ntwk[@]}
}

###
# On va lister l'enssemble de nos Environment a disposition dans le répertoire /home/elips/dev_conf/env/*
function check_env_conf ()
{
	# On récupère nos environments locaux disponibles
	i=0
	for filename in $(ls ${env_path_directory}); do
		env_file_lst[$i]=${filename%*${env_file_decoration}}
		i=$(($i + 1))
	done
	echo ">> Types d'environment a disposition  sur la machine locale : ${i} (${env_file_lst[@]})"

	# On fait de même pour chacune des machines distantes
	for remote_host in ${internal_ntwk[@]}; do
		k=0
		for filename in $(rsh ${remote_host} ls ${env_path_directory}); do
			eval ${remote_host}${env_decoration}[$k]=${filename%*${env_file_decoration}}
			k=$(($k + 1))
		done
		echo -n ">> Types d'environment a disposition  sur la machine distante "; eval echo -n ${remote_host}; echo -n " : ${k} ("; eval echo -n \${$remote_host$env_decoration[@]}; echo ")"
	done
}

###
# Fonction de verification du resultat de parsing
function verify_parse_rslt ()
{
	# On récupère notre réultat en local
	local __result=$1
	# On vérifie
	if [ $__result != 1 ] ; then
		echo " Fail ! Abandon de la diffusion ... voir --help ou -h pour l'usage"
		exit 1
	else
		echo " Find !"
	fi
}

### 
# Fonction de verification de nos environements locaux
function parse_local_arg ()
{
	# On stocke notre résultat en local
	local __result=0

	#On regarde le type de l'argument d'après notre liste locale
	echo -n ">> Fichier de configuration local correspondant à l'argument \"${argument}\" :"
	for (( i=0; i<${#env_file_lst[@]}; i++ )); do
		if [ "${env_file_lst[$i]}" = "${argument}" ] ; then
			# "trouvé"
			__result=1
		fi
	done

	# On return
	return $__result
}

###
# Fonction de verification de nos environments distants
function parse_remote_arg ()
{
	# On stocke notre résultat en local & l'argument
	local __remote_host=$1
	local __result=0

	# On scan
	echo -n ">> Fichier de configuration distant sur $remote_host correspondant à l'argument \"${argument}\" :"
	eval internal_sub_sz=\${#$__remote_host$env_decoration[@]}
	for (( i=0; i<$internal_sub_sz; i++)); do
		eval internal_sub_buffer=\${$__remote_host$env_decoration[$i]}
		if [  "$internal_sub_buffer" = "${argument}" ] ; then
			__result=1
		fi
	done 
	
	# On return
	return $__result
}

###
# Procedure de parsing local
function local_parse_routines ()
{
	# Check en local
	parse_local_arg
	#  On verifie
	verify_parse_rslt $?
}

##
# Procedure de parsing distant
function remote_parse_routines ()
{
	# On fait de même pour chacune des machines distantes
	for remote_host in ${internal_ntwk[@]}; do
		# Check Distant
		parse_remote_arg ${remote_host}
		# On verifie
		verify_parse_rslt $?
	done 
}

###
# Procedure de pré-parsing des options 
function pre_parse_routines ()
{
	# On determine le type <----- On rajoutera ici les options utlérieures pour le script !
	# On ne traite pas l'argument
	case ${argument} in	
		# Aide
  		"--help"|"-h")
			info_printing
		;;
		# Version
  		"--version"|"-v")
			echo; echo "Switch Environment Script ${script_version}"; echo
			exit 1
		;;
		# Erreur options non-traité
		$(echo "${argument}" | grep -e "\-[a-zA-Z0-9]*"))
			echo; echo "Aucune option correspondante trouvée ! Abandon de la diffusion ... voir --help ou -h pour l'usage"; echo
			exit 1
		;;
		# Aucun argument
		"")
			echo; echo "Aucun(e) paramètre/option correspondant(e) trouvé(e) ! Abandon de la diffusion ... voir --help ou -h pour l'usage"; echo
			exit 1
		;;
	esac
}

###
# On check que la liste d'argument est non-nulle
# > Normalement un seul argument est accepté a savoir la version a diffuser
function check_arg_lst ()
{
	# SI on est pas en pré-parsing
	if [ $1 != 1 ] ; then
		# Procedure de parsing local
		local_parse_routines
		# Procedure de parsing ditsant
		remote_parse_routines
	else
		# Procedure de pre-parsing
		pre_parse_routines
	fi
}

# ============================================================== #
# 						ROUTINES FUNCTIONS DECLARATION							#
# ============================================================== #

###
# Routines d'encapsulations des methodes de vérification
function perform_checkout_routines ()
{
	echo "----  Network Mapping"
	check_ntwk_conf
	check_ntwk_sz

	echo "----  Scan Environment"
	check_env_conf

	echo "----  Parse & Check argument"
	check_arg_lst 0
}



# ============================================================== #read
# 								SCRIPT STARTING POINT								#
# ============================================================== #

# On pré-parse 
check_arg_lst 1

# On Débute notre routines de test
echo
echo "_______Begin_Checkout_Routines_______"
perform_checkout_routines
echo "_______End_Checkout_Routines_______"
	
# On informe l'utilisateur 
bContinue=0
while [ $bContinue != 1 ] ; do
	echo; echo "==== [ATTENTION] : ==== "; echo -n " le processus relancera chacunes des machines du réseau configuré, assurez-vous ne n'avoir plus aucun travail en cours. Continuer ? [y/n]  : "
	read response
	# On traite la réponse
	case ${response} in	
		# Yes
  		"y"|"Y")
			bContinue=1
		;;
		# No
		"n"|"N")
			echo " Abandon de la diffusion ... voir --help ou -h pour l'usage";
			exit 1
		;;
		# else
		*)
			echo " réponse incorrecte ! reformulez svp.";
		;;
	esac
done

# Validation début du traitement
echo; echo "_______Begin_Process_______"

# On loop sur chacun des elements distants
for remote_host in ${internal_ntwk[@]}; do

	echo; echo "[${remote_host}]"

	# Redirection du lien symbolique 
	echo " > rsh -l ${rsh_login} ${remote_host} ln -sf ${env_path_directory}${argument}${env_file_decoration} ${link_path_directory}${link_base_name}${env_file_decoration}"
	rsh -l ${rsh_login} ${remote_host} ln -sf ${env_path_directory}${argument}${env_file_decoration} ${link_path_directory}${link_base_name}${env_file_decoration}

	# Reboot
	echo " > rsh -l ${rsh_login} ${remote_host} reboot"
	rsh -l ${rsh_login} ${remote_host} reboot

done

# Sans oublier la machine locale
echo; echo "[localhost]"

# Redirection du lien symbolique 
echo " > ln -sf ${env_path_directory}${argument}${env_file_decoration} ${link_path_directory}${link_base_name}${env_file_decoration}"
ln -sf ${env_path_directory}${argument}${env_file_decoration} ${link_path_directory}${link_base_name}${env_file_decoration}

# Reboot
echo -n " > localhost redemmarera dans environ"
for (( i=5; i!=0; i-- )); do
	echo -n " ${i}s..."
	sleep 1
done
echo " reboot ! Bye"
echo; echo "_______End_Process_______"; echo

# juste pour laisser le temps de lire
sleep 1
reboot

