#!/bin/bash

##############################################################################
## Entry point to the LABSIM Development Environment						##
##############################################################################

# construct the information toolchain about the current environment
declare LABSIM_DEV_DIST="LABSIM Development Environment distribution :"

# DRI administrated host
if [ $(( $LABSIM_DEV_ID & $LABSIM_DRI_MASK )) -eq $LABSIM_DRI_MASK ]; then
	LABSIM_DRI_HOST_ADMIN=1
	export LABSIM_DRI_HOST_ADMIN
	LABSIM_DEV_DIST="$LABSIM_DEV_DIST\n\t- [DRI host admin]"
fi

# Version deployment
if [ -f "$DEVTK_ROOT/script/linux/versions.sh" ]; then 
	source $DEVTK_ROOT/script/linux/versions.sh
else
	echo "Erreur dans la configuration de votre environment de travail... Contactez les administrateurs: Christian S. ou Nawfel K."
fi

# Global environment mapping -- should always be set
if [ $(( $LABSIM_DEV_ID & $LABSIM_COMMON_MASK )) -eq $LABSIM_COMMON_MASK ]; then
	source $DEVTK_ROOT/script/linux/package/global.conf.sh
	source $DEVTK_ROOT/script/linux/package/progiciels.conf.sh
	source $DEVTK_ROOT/script/linux/package/labsim_common.conf.sh
	LABSIM_DEV_DIST="$LABSIM_DEV_DIST\n\t- [Labsim common]"
else
	echo " .... [WARNING] LABSIM Common minimal requirement failed ? there should be an error somewhere ..."
fi

# Colosses specific environment mapping
if [ $(( $LABSIM_DEV_ID & $LABSIM_COLOSSES_MASK )) -eq $LABSIM_COLOSSES_MASK ]; then
	source $DEVTK_ROOT/script/linux/package/labsim_colosses.conf.sh
	LABSIM_DEV_DIST="$LABSIM_DEV_DIST\n\t- [Labsim Colosses]"
fi

# Olympiens specific environment mapping
if [ $(( $LABSIM_DEV_ID & $LABSIM_OLYMPIENS_MASK )) -eq $LABSIM_OLYMPIENS_MASK ]; then
	source $DEVTK_ROOT/script/linux/package/labsim_olympiens.conf.sh
	LABSIM_DEV_DIST="$LABSIM_DEV_DIST\n\t- [Labsim Olympiens]"
fi

# Titans specific environment mapping
if [ $(( $LABSIM_DEV_ID & $LABSIM_TITANS_MASK )) -eq $LABSIM_TITANS_MASK ]; then
	source $DEVTK_ROOT/script/linux/package/hla.conf.sh
	source $DEVTK_ROOT/script/linux/package/dds.conf.sh
	source $DEVTK_ROOT/script/linux/package/labsim_titans.conf.sh
	LABSIM_DEV_DIST="$LABSIM_DEV_DIST\n\t- [Labsim Titans]"
fi

# Contract specific environment mapping
if [ $(( $LABSIM_DEV_ID & $LABSIM_CONTRACT_MASK )) -eq $LABSIM_CONTRACT_MASK ]; then
	source $DEVTK_ROOT/script/linux/package/labsim_contract.conf.sh
	LABSIM_DEV_DIST="$LABSIM_DEV_DIST\n\t- [Labsim Contract]"
fi

export LABSIM_DEV_DIST

# == EOF
