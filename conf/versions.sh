#!/bin/bash
#
# Versions files
#
# On place ici chacune des versions des outils utilisés 
#
# (Valentines's Day)
# 14/02/2012 - Kinani Nawfel
#
#################################################

# set progiciel home directory
if [ -z ${PRO_HOME+x} ]; then 
	# $whoami's home dir
	tmp=$(eval echo "~$(whoami)")
	current_progiciels_home="$tmp/Progiciels"
else 
	current_progiciels_home=${PRO_HOME}
fi

###
# Fonction de verification du versionning du progiciels requis
function split_version () 
{
	local major_version=0
	local minor_version=0
	local patch_version=0

	for dirname in $(ls -d $current_progiciels_home/$1-*); do

		local tmp_version=$(echo $dirname | awk -F"-" '{print $NF}')
		local tmp_major_version=$(echo $tmp_version | awk -F"." '{print $1}')
		local tmp_minor_version=$(echo $tmp_version | awk -F"." '{print $2}')
		local tmp_patch_version=$(echo $tmp_version | awk -F"." '{print $3}')

		if [ "$tmp_major_version" -gt "$major_version" ]; then
			major_version=$tmp_major_version
			minor_version=$tmp_minor_version
			patch_version=$tmp_patch_version
		else
			if [ "$tmp_minor_version" -gt "$minor_version" ]; then
				minor_version=$tmp_minor_version
				patch_version=$tmp_patch_version
			else
				if [ "$tmp_patch_version" -gt "$patch_version" ]; then
					patch_version=$tmp_patch_version
				fi
			fi
		fi

	done

    if unset -v "$2"; then
    	eval $2=\"\$major_version\"
    fi
    if unset -v "$3"; then
    	eval $3=\"\$minor_version\"
    fi
    if unset -v "$4"; then
    	eval $4=\"\$patch_version\"
    fi
	if unset -v "$5"; then				
    	eval $5=\"\$major_version.$minor_version.$patch_version\"
    fi
	
}

# MPC versions
MPC_MAJ_VER=0
MPC_MIN_VER=0
MPC_PATCH_VER=0 
MPC_VERSION=0

# MPFR versions
MPFR_MAJ_VER=0
MPFR_MIN_VER=0
MPFR_PATCH_VER=0 
MPFR_VERSION=0

# GMP versions
GMP_MAJ_VER=0
GMP_MIN_VER=0
GMP_PATCH_VER=0 
GMP_VERSION=0

# AutoGen versions
AUTOGEN_MAJ_VER=0
AUTOGEN_MIN_VER=0
AUTOGEN_PATCH_VER=0 
AUTOGEN_VERSION=0

# GCC versions
GCC_MAJ_VER=0
GCC_MIN_VER=0
GCC_PATCH_VER=0 
GCC_VERSION=0

# Doxygen versions
DOXYGEN_MAJ_VER=0
DOXYGEN_MIN_VER=0
DOXYGEN_PATCH_VER=0 
DOXYGEN_VERSION=0

# Xerces-C++ versions
XERCESC_MAJ_VER=0
XERCESC_MIN_VER=0
XERCESC_PATCH_VER=0 
XERCESC_VERSION=0

# GLM versions
GLM_MAJ_VER=0
GLM_MIN_VER=0
GLM_PATCH_VER=0 
GLM_VERSION=0

# GLFW versions
GLFW_MAJ_VER=0
GLFW_MIN_VER=0
GLFW_PATCH_VER=0 
GLFW_VERSION=0

# CMAKE versions
CMAKE_MAJ_VER=0
CMAKE_MIN_VER=0
CMAKE_PATCH_VER=0 
CMAKE_VERSION=0

# Boost versions
BOOST_MAJ_VER=0
BOOST_MIN_VER=0
BOOST_PATCH_VER=0 
BOOST_VERSION=0

# OpenSceneGraph versions
OSG_MAJ_VER=0
OSG_MIN_VER=0
OSG_PATCH_VER=0 
OSG_VERSION=0

# SilverLining versions
SILVERLINING_MAJ_VER=0
SILVERLINING_MIN_VER=0
SILVERLINING_PATCH_VER=0
SILVERLINING_VERSION=0

# FFTSS versions
FFTSS_MAJ_VER=0
FFTSS_MIN_VER=0
FFTSS_PATCH_VER=0
FFTSS_VERSION=0

# Triton versions
TRITON_MAJ_VER=0
TRITON_MIN_VER=0
TRITON_PATCH_VER=0
TRITON_VERSION=0

# CEGUI versions
CEGUI_MAJ_VER=0
CEGUI_MIN_VER=0
CEGUI_PATCH_VER=0 
CEGUI_VERSION=0

# CEED versions
#split_version "ceed" MPC_MAJ_VER MPC_MIN_VER MPC_PATCH_VER MPC_VERSION
#CEED_VERSION=snapshot11

# QT versions
QT_MAJ_VER=0
QT_MIN_VER=0
QT_PATCH_VER=0 
QT_VERSION=0

# QT Creator versions
QTCREATOR_MAJ_VER=0
QTCREATOR_MIN_VER=0
QTCREATOR_PATCH_VER=0 
QTCREATOR_VERSION=0

# OpenSpliceDDS versions
OSPL_MAJ_VER=0
OSPL_MIN_VER=0
OSPL_PATCH_VER=0 
OSPL_VERSION=0

# Then split then into version

# Global environment mapping -- should always be set
if [ $(( $LABSIM_DEV_ID & $LABSIM_COMMON_MASK )) -eq $LABSIM_COMMON_MASK ]; then
	split_version "mpc" MPC_MAJ_VER MPC_MIN_VER MPC_PATCH_VER MPC_VERSION
	split_version "mpfr" MPFR_MAJ_VER MPFR_MIN_VER MPFR_PATCH_VER MPFR_VERSION
	split_version "gmp" GMP_MAJ_VER GMP_MIN_VER GMP_PATCH_VER GMP_VERSION
	split_version "autogen" AUTOGEN_MAJ_VER AUTOGEN_MIN_VER AUTOGEN_PATCH_VER AUTOGEN_VERSION
	split_version "gcc" GCC_MAJ_VER GCC_MIN_VER GCC_PATCH_VER GCC_VERSION
	split_version "doxygen" DOXYGEN_MAJ_VER DOXYGEN_MIN_VER DOXYGEN_PATCH_VER DOXYGEN_VERSION
	split_version "xercesc" XERCESC_MAJ_VER XERCESC_MIN_VER XERCESC_PATCH_VER XERCESC_VERSION
	split_version "cmake" CMAKE_MAJ_VER CMAKE_MIN_VER CMAKE_PATCH_VER CMAKE_VERSION
	split_version "boost" BOOST_MAJ_VER BOOST_MIN_VER BOOST_PATCH_VER BOOST_VERSION
	split_version "osg" OSG_MAJ_VER OSG_MIN_VER OSG_PATCH_VER OSG_VERSION
	split_version "silverlining" SILVERLINING_MAJ_VER SILVERLINING_MIN_VER SILVERLINING_PATCH_VER SILVERLINING_VERSION
	split_version "fftss" FFTSS_MAJ_VER FFTSS_MIN_VER FFTSS_PATCH_VER FFTSS_VERSION
	split_version "triton" TRITON_MAJ_VER TRITON_MIN_VER TRITON_PATCH_VER TRITON_VERSION
	split_version "qt" QT_MAJ_VER QT_MIN_VER QT_PATCH_VER QT_VERSION
	split_version "qt-creator" QTCREATOR_MAJ_VER QTCREATOR_MIN_VER QTCREATOR_PATCH_VER QTCREATOR_VERSION
fi

# Olympiens specific environment mapping
if [ $(( $LABSIM_DEV_ID & $LABSIM_OLYMPIENS_MASK )) -eq $LABSIM_OLYMPIENS_MASK ]; then
	split_version "glm" GLM_MAJ_VER GLM_MIN_VER GLM_PATCH_VER GLM_VERSION
	split_version "glfw" GLFW_MAJ_VER GLFW_MIN_VER GLFW_PATCH_VER GLFW_VERSION
	split_version "cegui" CEGUI_MAJ_VER CEGUI_MIN_VER CEGUI_PATCH_VER CEGUI_VERSION
fi

# Titans specific environment mapping
if [ $(( $LABSIM_DEV_ID & $LABSIM_TITANS_MASK )) -eq $LABSIM_TITANS_MASK ]; then
	split_version "opensplicedds" OSPL_MAJ_VER OSPL_MIN_VER OSPL_PATCH_VER OSPL_VERSION
fi

# debug
if [ ! -z ${DEVTK_DEBUG_ON+x} ]; then 
	echo "--------------------------------------------------------------------"
	echo "mpc : $MPC_MAJ_VER $MPC_MIN_VER $MPC_PATCH_VER $MPC_VERSION"
	echo "mpfr : $MPFR_MAJ_VER $MPFR_MIN_VER $MPFR_PATCH_VER $MPFR_VERSION"
	echo "gmp : $GMP_MAJ_VER $GMP_MIN_VER $GMP_PATCH_VER $GMP_VERSION"
	echo "autogen : $AUTOGEN_MAJ_VER $AUTOGEN_MIN_VER $AUTOGEN_PATCH_VER $AUTOGEN_VERSION"
	echo "gcc : $GCC_MAJ_VER $GCC_MIN_VER $GCC_PATCH_VER $GCC_VERSION"
	echo "doxygen : $DOXYGEN_MAJ_VER $DOXYGEN_MIN_VER $DOXYGEN_PATCH_VER $DOXYGEN_VERSION"
	echo "xerces-c : $XERCES_MAJ_VER $XERCES_MIN_VER $XERCES_PATCH_VER $XERCES_VERSION"
	echo "glm : $GLM_MAJ_VER $GLM_MIN_VER $GLM_PATCH_VER $GLM_VERSION"
	echo "glfw : $GLFW_MAJ_VER $GLFW_MIN_VER $GLFW_PATCH_VER $GLFW_VERSION"
	echo "cmake : $CMAKE_MAJ_VER $CMAKE_MIN_VER $CMAKE_PATCH_VER $CMAKE_VERSION"
	echo "boost : $BOOST_MAJ_VER $BOOST_MIN_VER $BOOST_PATCH_VER $BOOST_VERSION"
	echo "osg : $OSG_MAJ_VER $OSG_MIN_VER $OSG_PATCH_VER $OSG_VERSION"
	echo "silverlining : $SILVERLINING_MAJ_VER $SILVERLINING_MIN_VER $SILVERLINING_PATCH_VER $SILVERLINING_VERSION"
	echo "fftss : $FFTSS_MAJ_VER $FFTSS_MIN_VER $FFTSS_PATCH_VER $FFTSS_VERSION"
	echo "triton : $TRITON_MAJ_VER $TRITON_MIN_VER $TRITON_PATCH_VER $TRITON_VERSION"
	echo "cegui : $CEGUI_MAJ_VER $CEGUI_MIN_VER $CEGUI_PATCH_VER $CEGUI_VERSION"
	echo "qt: $QT_MAJ_VER $QT_MIN_VER $QT_PATCH_VER $QT_VERSION"
	echo "qt-creator: $QTCREATOR_MAJ_VER $QTCREATOR_MIN_VER $QTCREATOR_PATCH_VER $QTCREATOR_VERSION"
	echo "opensplicedds : $OSPL_MAJ_VER $OSPL_MIN_VER $OSPL_PATCH_VER $OSPL_VERSION"
	echo "--------------------------------------------------------------------"
fi
