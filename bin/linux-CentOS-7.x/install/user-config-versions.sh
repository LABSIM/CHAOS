#!/bin/bash
#
# Target versions files
#
# On place ici chacune des versions des outils que l'on souhaite installer 
#
# (Valentines's Day)
# 14/02/2012 - Kinani Nawfel
#
#################################################

# MPC versions
MPC_INSTALL_TARGET_MAJ_VER=1
MPC_INSTALL_TARGET_MIN_VER=0
MPC_INSTALL_TARGET_PATCH_VER=3
MPC_INSTALL_TARGET_VERSION=${MPC_INSTALL_TARGET_MAJ_VER}.${MPC_INSTALL_TARGET_MIN_VER}.${MPC_INSTALL_TARGET_PATCH_VER}

# MPFR versions
MPFR_INSTALL_TARGET_MAJ_VER=3
MPFR_INSTALL_TARGET_MIN_VER=1
MPFR_INSTALL_TARGET_PATCH_VER=3
MPFR_INSTALL_TARGET_VERSION=${MPFR_INSTALL_TARGET_MAJ_VER}.${MPFR_INSTALL_TARGET_MIN_VER}.${MPFR_INSTALL_TARGET_PATCH_VER}

# GMP versions
GMP_INSTALL_TARGET_MAJ_VER=6
GMP_INSTALL_TARGET_MIN_VER=0
GMP_INSTALL_TARGET_PATCH_VER=0
GMP_INSTALL_TARGET_VERSION=${GMP_INSTALL_TARGET_MAJ_VER}.${GMP_INSTALL_TARGET_MIN_VER}.${GMP_INSTALL_TARGET_PATCH_VER}

# AutoGen versions
#
# -- Caution -- 
# v5.18.5 can't successfully build ... I don't know why
#
AUTOGEN_INSTALL_TARGET_MAJ_VER=5
AUTOGEN_INSTALL_TARGET_MIN_VER=18
AUTOGEN_INSTALL_TARGET_PATCH_VER=4
AUTOGEN_INSTALL_TARGET_VERSION=${AUTOGEN_INSTALL_TARGET_MAJ_VER}.${AUTOGEN_INSTALL_TARGET_MIN_VER}.${AUTOGEN_INSTALL_TARGET_PATCH_VER}

# GCC versions
GCC_INSTALL_TARGET_MAJ_VER=5
GCC_INSTALL_TARGET_MIN_VER=2
GCC_INSTALL_TARGET_PATCH_VER=0
GCC_INSTALL_TARGET_VERSION=${GCC_INSTALL_TARGET_MAJ_VER}.${GCC_INSTALL_TARGET_MIN_VER}.${GCC_INSTALL_TARGET_PATCH_VER}

# Doxygen versions
DOXYGEN_INSTALL_TARGET_MAJ_VER=1
DOXYGEN_INSTALL_TARGET_MIN_VER=8
DOXYGEN_INSTALL_TARGET_PATCH_VER=11
DOXYGEN_INSTALL_TARGET_VERSION=${DOXYGEN_INSTALL_TARGET_MAJ_VER}.${DOXYGEN_INSTALL_TARGET_MIN_VER}.${DOXYGEN_INSTALL_TARGET_PATCH_VER}

# Xerces-C++ versions
XERCESC_INSTALL_TARGET_MAJ_VER=3
XERCESC_INSTALL_TARGET_MIN_VER=1
XERCESC_INSTALL_TARGET_PATCH_VER=2
XERCESC_INSTALL_TARGET_VERSION=${XERCESC_INSTALL_TARGET_MAJ_VER}.${XERCESC_INSTALL_TARGET_MIN_VER}.${XERCESC_INSTALL_TARGET_PATCH_VER}

# GLM versions
GLM_INSTALL_TARGET_MAJ_VER=0
GLM_INSTALL_TARGET_MIN_VER=9
GLM_INSTALL_TARGET_PATCH_VER=7
GLM_INSTALL_TARGET_VERSION=${GLM_INSTALL_TARGET_MAJ_VER}.${GLM_INSTALL_TARGET_MIN_VER}.${GLM_INSTALL_TARGET_PATCH_VER}

# GLFW versions
GLFW_INSTALL_TARGET_MAJ_VER=3
GLFW_INSTALL_TARGET_MIN_VER=1
GLFW_INSTALL_TARGET_PATCH_VER=1
GLFW_INSTALL_TARGET_VERSION=${GLFW_INSTALL_TARGET_MAJ_VER}.${GLFW_INSTALL_TARGET_MIN_VER}.${GLFW_INSTALL_TARGET_PATCH_VER}

# CMAKE versions
CMAKE_INSTALL_TARGET_MAJ_VER=3
CMAKE_INSTALL_TARGET_MIN_VER=3
CMAKE_INSTALL_TARGET_PATCH_VER=1
CMAKE_INSTALL_TARGET_VERSION=$CMAKE_INSTALL_TARGET_MAJ_VER.$CMAKE_INSTALL_TARGET_MIN_VER.$CMAKE_INSTALL_TARGET_PATCH_VER

# Boost versions
BOOST_INSTALL_TARGET_MAJ_VER=1
BOOST_INSTALL_TARGET_MIN_VER=59
BOOST_INSTALL_TARGET_PATCH_VER=0
BOOST_INSTALL_TARGET_VERSION=${BOOST_INSTALL_TARGET_MAJ_VER}.${BOOST_INSTALL_TARGET_MIN_VER}.${BOOST_INSTALL_TARGET_PATCH_VER}

# OpenSceneGraph versions
OSG_INSTALL_TARGET_MAJ_VER=3
OSG_INSTALL_TARGET_MIN_VER=4
OSG_INSTALL_TARGET_PATCH_VER=0
OSG_INSTALL_TARGET_VERSION=${OSG_INSTALL_TARGET_MAJ_VER}.${OSG_INSTALL_TARGET_MIN_VER}.${OSG_INSTALL_TARGET_PATCH_VER}

# SilverLining versions
SILVERLINING_INSTALL_TARGET_MAJ_VER=4
SILVERLINING_INSTALL_TARGET_MIN_VER=0
SILVERLINING_INSTALL_TARGET_PATCH_VER=22
SILVERLINING_INSTALL_TARGET_VERSION=${SILVERLINING_INSTALL_TARGET_MAJ_VER}.${SILVERLINING_INSTALL_TARGET_MIN_VER}.${SILVERLINING_INSTALL_TARGET_PATCH_VER}

# FFTSS versions
FFTSS_INSTALL_TARGET_MAJ_VER=3
FFTSS_INSTALL_TARGET_MIN_VER=0
FFTSS_INSTALL_TARGET_PATCH_VER=0
FFTSS_INSTALL_TARGET_VERSION=${FFTSS_INSTALL_TARGET_MAJ_VER}.${FFTSS_INSTALL_TARGET_MIN_VER}.${FFTSS_INSTALL_TARGET_PATCH_VER}

# Triton versions
TRITON_INSTALL_TARGET_MAJ_VER=3
TRITON_INSTALL_TARGET_MIN_VER=35
TRITON_INSTALL_TARGET_PATCH_VER=0
TRITON_INSTALL_TARGET_VERSION=${TRITON_INSTALL_TARGET_MAJ_VER}.${TRITON_INSTALL_TARGET_MIN_VER}.${TRITON_INSTALL_TARGET_PATCH_VER}

# CEGUI versions
CEGUI_INSTALL_TARGET_MAJ_VER=0
CEGUI_INSTALL_TARGET_MIN_VER=8
CEGUI_INSTALL_TARGET_PATCH_VER=7
CEGUI_INSTALL_TARGET_VERSION=$CEGUI_INSTALL_TARGET_MAJ_VER.$CEGUI_INSTALL_TARGET_MIN_VER.$CEGUI_INSTALL_TARGET_PATCH_VER

# CEED versions
#CEED_INSTALL_TARGET_VERSION=snapshot11

# QT versions
QT_INSTALL_TARGET_MAJ_VER=5
QT_INSTALL_TARGET_MIN_VER=5
QT_INSTALL_TARGET_PATCH_VER=0
QT_INSTALL_TARGET_VERSION=$QT_INSTALL_TARGET_MAJ_VER.$QT_INSTALL_TARGET_MIN_VER.$QT_INSTALL_TARGET_PATCH_VER

# QT Creator versions
QTCREATOR_INSTALL_TARGET_MAJ_VER=3
QTCREATOR_INSTALL_TARGET_MIN_VER=5
QTCREATOR_INSTALL_TARGET_PATCH_VER=0
QTCREATOR_INSTALL_TARGET_VERSION=$QTCREATOR_INSTALL_TARGET_MAJ_VER.$QTCREATOR_INSTALL_TARGET_MIN_VER.$QTCREATOR_INSTALL_TARGET_PATCH_VER

# OpenSpliceDDS versions
OSPL_INSTALL_TARGET_MAJ_VER=6
OSPL_INSTALL_TARGET_MIN_VER=4
OSPL_INSTALL_TARGET_PATCH_VER=0
OSPL_INSTALL_TARGET_VERSION=$OSPL_INSTALL_TARGET_MAJ_VER.$OSPL_INSTALL_TARGET_MIN_VER.$OSPL_INSTALL_TARGET_PATCH_VER
