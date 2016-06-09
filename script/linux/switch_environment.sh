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

# Absolute path to this script
SCRIPT=$(readlink -f "$BASH_SOURCE")
# Absolute path this script is in
SCRIPTPATH=$(dirname "$SCRIPT")

# ============================================================== #
# 				BASIC VARIABLES DECLARATION						 #
# ============================================================== #

env_requested="$1"

major_version=1
minor_version=2
patch_version=81   

script_version="v.${major_version}.${minor_version}.${patch_version}"

rsh_login=$(whoami)

root_directory=$(readlink -f "$SCRIPTPATH/../../")

link_base_name="labsim"
link_path_directory="$(eval echo "~$(whoami)")/."

env_decoration="_env_file_lst"
env_file_decoration=".env.sh"
env_path_directory="${root_directory}/script/linux/env/"

declare -a env_file_lst

# ============================================================== #
# 				BASIC FUNCTIONS DECLARATION						 #
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
	echo " ${root_directory}/etc/networkMap.conf.sh"
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
	echo "  {command} [[ARG1] | OPTION]"
	echo
	echo "ARG:"
	echo "  - ARG1 > Le type de l'environment de travail a"
	echo "  diffuser, ex: DEV"
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
	if [ -f "${root_directory}/etc/networkMap.conf.sh" ];  then
		. "${root_directory}/etc/networkMap.conf.sh"
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
# On va lister l'enssemble de nos Environment a disposition dans le répertoire /env/*
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

	#On regarde le type de l'env_requested d'après notre liste locale
	echo -n ">> Fichier de configuration local correspondant à l'env_requested \"${env_requested}\" :"
	for (( i=0; i<${#env_file_lst[@]}; i++ )); do
		if [ "${env_file_lst[$i]}" = "${env_requested}" ] ; then
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
	# On stocke notre résultat en local & l'env_requested
	local __remote_host=$1
	local __result=0

	# On scan
	echo -n ">> Fichier de configuration distant sur $remote_host correspondant à l'env_requested \"${env_requested}\" :"
	eval internal_sub_sz=\${#$__remote_host$env_decoration[@]}
	for (( i=0; i<$internal_sub_sz; i++)); do
		eval internal_sub_buffer=\${$__remote_host$env_decoration[$i]}
		if [  "$internal_sub_buffer" = "${env_requested}" ] ; then
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
	# On ne traite pas l'env_requested
	case ${env_requested} in	
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
		$(echo "${env_requested}" | grep -e "\-[a-zA-Z0-9]*"))
			echo; echo -e "Aucune option correspondante trouvée ! Abandon de la diffusion ... voir --help ou -h pour l'usage \n\n"; echo
			exit 1
		;;
		# Aucun env_requested
		"")
			echo; echo -e "Aucun(e) paramètre/option correspondant(e) trouvé(e) ! Abandon de la diffusion ... voir --help ou -h pour l'usage \n\n"; echo
			exit 1
		;;
	esac
}

###
# On check que la liste d'env_requested est non-nulle
# > Normalement un seul env_requested est accepté a savoir la version a diffuser
function check_arg_lst ()
{
	# SI on est pas en pré-parsing
	if [ -f $1 ]; then
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
# 				ROUTINES FUNCTIONS DECLARATION					 #
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

	echo "----  Parse & Check env_requested"
	check_arg_lst 0
}



# ============================================================== #
# 					SCRIPT STARTING POINT						 #
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
	echo; echo "==== [ATTENTION] : ==== "; echo -n " le processus reconfigurera l'ensemble des machines définies, assurez-vous ne n'avoir plus aucun travail en cours. Continuer ? [y/n]  : "
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
	echo " > rsh -l ${rsh_login} ${remote_host} ln -sf ${env_path_directory}${env_requested}${env_file_decoration} ${link_path_directory}${link_base_name}${env_file_decoration}"
	rsh -l ${rsh_login} ${remote_host} ln -sf ${env_path_directory}${env_requested}${env_file_decoration} ${link_path_directory}${link_base_name}${env_file_decoration}
	
done

# Sans oublier la machine locale
echo; echo "[localhost]"

# Redirection du lien symbolique 
echo " > ln -sf ${env_path_directory}${env_requested}${env_file_decoration} ${link_path_directory}${link_base_name}${env_file_decoration}"
ln -sf ${env_path_directory}${env_requested}${env_file_decoration} ${link_path_directory}${link_base_name}${env_file_decoration}

# Fin
echo " End ! Bye"
echo; echo "_______End_Process_______"; echo

# EOF


