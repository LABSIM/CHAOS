#!/bin/bash

#
# GAIA : required LABSIM ground software ecosystem
# Copyright (C) 2012-2016  Nawfel KINANI
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; see the file COPYING.
# If not, see <http://www.gnu.org/licenses/>.
#

#################################################
#
# Target versions files
#
# On place ici chacune des versions des outils que l'on souhaite installer 
#
# (Valentines's Day)
# 14/02/2012 - Kinani Nawfel
#
#################################################

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

# Perl versions
PERL_INSTALL_TARGET_MAJ_VER=5
PERL_INSTALL_TARGET_MIN_VER=24
PERL_INSTALL_TARGET_PATCH_VER=0
PERL_INSTALL_TARGET_VERSION=${PERL_INSTALL_TARGET_MAJ_VER}.${PERL_INSTALL_TARGET_MIN_VER}.${PERL_INSTALL_TARGET_PATCH_VER}

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
CMAKE_INSTALL_TARGET_MIN_VER=6
CMAKE_INSTALL_TARGET_PATCH_VER=1
CMAKE_INSTALL_TARGET_VERSION=$CMAKE_INSTALL_TARGET_MAJ_VER.$CMAKE_INSTALL_TARGET_MIN_VER.$CMAKE_INSTALL_TARGET_PATCH_VER

# Boost versions
BOOST_INSTALL_TARGET_MAJ_VER=1
BOOST_INSTALL_TARGET_MIN_VER=61
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
SILVERLINING_INSTALL_TARGET_PATCH_VER=50
SILVERLINING_INSTALL_TARGET_VERSION=${SILVERLINING_INSTALL_TARGET_MAJ_VER}.${SILVERLINING_INSTALL_TARGET_MIN_VER}.${SILVERLINING_INSTALL_TARGET_PATCH_VER}

# FFTSS versions
FFTSS_INSTALL_TARGET_MAJ_VER=3
FFTSS_INSTALL_TARGET_MIN_VER=0
FFTSS_INSTALL_TARGET_PATCH_VER=0
FFTSS_INSTALL_TARGET_VERSION=${FFTSS_INSTALL_TARGET_MAJ_VER}.${FFTSS_INSTALL_TARGET_MIN_VER}.${FFTSS_INSTALL_TARGET_PATCH_VER}

# Triton versions
TRITON_INSTALL_TARGET_MAJ_VER=3
TRITON_INSTALL_TARGET_MIN_VER=58
TRITON_INSTALL_TARGET_PATCH_VER=0
TRITON_INSTALL_TARGET_VERSION=${TRITON_INSTALL_TARGET_MAJ_VER}.${TRITON_INSTALL_TARGET_MIN_VER}.${TRITON_INSTALL_TARGET_PATCH_VER}

# CEGUI versions
CEGUI_INSTALL_TARGET_MAJ_VER=0
CEGUI_INSTALL_TARGET_MIN_VER=8
CEGUI_INSTALL_TARGET_PATCH_VER=7
CEGUI_INSTALL_TARGET_VERSION=$CEGUI_INSTALL_TARGET_MAJ_VER.$CEGUI_INSTALL_TARGET_MIN_VER.$CEGUI_INSTALL_TARGET_PATCH_VER

# CEED versions
CEED_INSTALL_TARGET_MAJ_VER=0
CEED_INSTALL_TARGET_MIN_VER=8
CEED_INSTALL_TARGET_PATCH_VER=0
CEED_INSTALL_TARGET_VERSION=$CEED_INSTALL_TARGET_MAJ_VER.$CEED_INSTALL_TARGET_MIN_VER.$CEED_INSTALL_TARGET_PATCH_VER

# QT versions
QT_INSTALL_TARGET_MAJ_VER=5
QT_INSTALL_TARGET_MIN_VER=5
QT_INSTALL_TARGET_PATCH_VER=0
QT_INSTALL_TARGET_VERSION=$QT_INSTALL_TARGET_MAJ_VER.$QT_INSTALL_TARGET_MIN_VER.$QT_INSTALL_TARGET_PATCH_VER

# OpenSpliceDDS versions
OSPL_INSTALL_TARGET_MAJ_VER=6
OSPL_INSTALL_TARGET_MIN_VER=4
OSPL_INSTALL_TARGET_PATCH_VER=0
OSPL_INSTALL_TARGET_VERSION=$OSPL_INSTALL_TARGET_MAJ_VER.$OSPL_INSTALL_TARGET_MIN_VER.$OSPL_INSTALL_TARGET_PATCH_VER

# QT Creator versions
QTCREATOR_INSTALL_TARGET_MAJ_VER=3
QTCREATOR_INSTALL_TARGET_MIN_VER=5
QTCREATOR_INSTALL_TARGET_PATCH_VER=0
QTCREATOR_INSTALL_TARGET_VERSION=$QTCREATOR_INSTALL_TARGET_MAJ_VER.$QTCREATOR_INSTALL_TARGET_MIN_VER.$QTCREATOR_INSTALL_TARGET_PATCH_VER

# OpenCV versions
OPENCV_INSTALL_TARGET_MAJ_VER=3
OPENCV_INSTALL_TARGET_MIN_VER=1
OPENCV_INSTALL_TARGET_PATCH_VER=0
OPENCV_INSTALL_TARGET_VERSION=${OPENCV_INSTALL_TARGET_MAJ_VER}.${OPENCV_INSTALL_TARGET_MIN_VER}.${OPENCV_INSTALL_TARGET_PATCH_VER}

# HID API versions
HIDAPI_INSTALL_TARGET_MAJ_VER=0
HIDAPI_INSTALL_TARGET_MIN_VER=8
HIDAPI_INSTALL_TARGET_PATCH_VER=0
HIDAPI_INSTALL_TARGET_VERSION=${HIDAPI_INSTALL_TARGET_MAJ_VER}.${HIDAPI_INSTALL_TARGET_MIN_VER}.${HIDAPI_INSTALL_TARGET_PATCH_VER}

# JSONCPP versions
JSONCPP_INSTALL_TARGET_MAJ_VER=1
JSONCPP_INSTALL_TARGET_MIN_VER=7
JSONCPP_INSTALL_TARGET_PATCH_VER=5
JSONCPP_INSTALL_TARGET_VERSION=${JSONCPP_INSTALL_TARGET_MAJ_VER}.${JSONCPP_INSTALL_TARGET_MIN_VER}.${JSONCPP_INSTALL_TARGET_PATCH_VER}

# VRPN versions
VRPN_INSTALL_TARGET_MAJ_VER=0
VRPN_INSTALL_TARGET_MIN_VER=7
VRPN_INSTALL_TARGET_PATCH_VER=34
VRPN_INSTALL_TARGET_VERSION=${VRPN_INSTALL_TARGET_MAJ_VER}.${VRPN_INSTALL_TARGET_MIN_VER}.${VRPN_INSTALL_TARGET_PATCH_VER}

# OSVR lib functionality versions
OSVR_LIBFUNCTIONALITY_INSTALL_TARGET_MAJ_VER=0
OSVR_LIBFUNCTIONALITY_INSTALL_TARGET_MIN_VER=1
OSVR_LIBFUNCTIONALITY_INSTALL_TARGET_PATCH_VER=0
OSVR_LIBFUNCTIONALITY_INSTALL_TARGET_VERSION=${OSVR_LIBFUNCTIONALITY_INSTALL_TARGET_MAJ_VER}.${OSVR_LIBFUNCTIONALITY_INSTALL_TARGET_MIN_VER}.${OSVR_LIBFUNCTIONALITY_INSTALL_TARGET_PATCH_VER}

# OSVR core versions
OSVR_CORE_INSTALL_TARGET_MAJ_VER=0
OSVR_CORE_INSTALL_TARGET_MIN_VER=6
OSVR_CORE_INSTALL_TARGET_PATCH_VER=0
OSVR_CORE_INSTALL_TARGET_VERSION=${OSVR_CORE_INSTALL_TARGET_MAJ_VER}.${OSVR_CORE_INSTALL_TARGET_MIN_VER}.${OSVR_CORE_INSTALL_TARGET_PATCH_VER}

# OSVR display versions
OSVR_DISPLAY_INSTALL_TARGET_MAJ_VER=0
OSVR_DISPLAY_INSTALL_TARGET_MIN_VER=1
OSVR_DISPLAY_INSTALL_TARGET_PATCH_VER=0
OSVR_DISPLAY_INSTALL_TARGET_VERSION=${OSVR_DISPLAY_INSTALL_TARGET_MAJ_VER}.${OSVR_DISPLAY_INSTALL_TARGET_MIN_VER}.${OSVR_DISPLAY_INSTALL_TARGET_PATCH_VER}

# OSVR tracker viewer versions
OSVR_TRACKER_INSTALL_TARGET_MAJ_VER=0
OSVR_TRACKER_INSTALL_TARGET_MIN_VER=1
OSVR_TRACKER_INSTALL_TARGET_PATCH_VER=0
OSVR_TRACKER_INSTALL_TARGET_VERSION=${OSVR_TRACKER_INSTALL_TARGET_MAJ_VER}.${OSVR_TRACKER_INSTALL_TARGET_MIN_VER}.${OSVR_TRACKER_INSTALL_TARGET_PATCH_VER}

# OSVR Leap Motion plugin versions
OSVR_LEAPMOTION_INSTALL_TARGET_MAJ_VER=0
OSVR_LEAPMOTION_INSTALL_TARGET_MIN_VER=1
OSVR_LEAPMOTION_INSTALL_TARGET_PATCH_VER=0
OSVR_LEAPMOTION_INSTALL_TARGET_VERSION=${OSVR_LEAPMOTION_INSTALL_TARGET_MAJ_VER}.${OSVR_LEAPMOTION_INSTALL_TARGET_MIN_VER}.${OSVR_LEAPMOTION_INSTALL_TARGET_PATCH_VER}

# GO versions
GO_INSTALL_TARGET_MAJ_VER=1
GO_INSTALL_TARGET_MIN_VER=7
GO_INSTALL_TARGET_PATCH_VER=3
GO_INSTALL_TARGET_VERSION=${GO_INSTALL_TARGET_MAJ_VER}.${GO_INSTALL_TARGET_MIN_VER}.${GO_INSTALL_TARGET_PATCH_VER}

# PROTOBUF versions
PROTOBUF_INSTALL_TARGET_MAJ_VER=3
PROTOBUF_INSTALL_TARGET_MIN_VER=3
PROTOBUF_INSTALL_TARGET_PATCH_VER=0
PROTOBUF_INSTALL_TARGET_VERSION=${PROTOBUF_INSTALL_TARGET_MAJ_VER}.${PROTOBUF_INSTALL_TARGET_MIN_VER}.${PROTOBUF_INSTALL_TARGET_PATCH_VER}

# GRPC versions
GRPC_INSTALL_TARGET_MAJ_VER=1
GRPC_INSTALL_TARGET_MIN_VER=3
GRPC_INSTALL_TARGET_PATCH_VER=2
GRPC_INSTALL_TARGET_VERSION=${GRPC_INSTALL_TARGET_MAJ_VER}.${GRPC_INSTALL_TARGET_MIN_VER}.${GRPC_INSTALL_TARGET_PATCH_VER}
