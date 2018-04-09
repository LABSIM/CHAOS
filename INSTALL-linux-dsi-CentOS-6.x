# ---------------------------------------------------------------------------- #
# 						I - Package (YUM) [required]						   #
# ---------------------------------------------------------------------------- #

	-> [sudo required] script/linux/install/CentOS-6.x/install_Dependencies.sh

# ---------------------------------------------------------------------------- #
# 					II - Common Libraries [required]                           #
# ---------------------------------------------------------------------------- #

	-> script/linux/install/CentOS-6.x/install_PERL.sh	
	-> script/linux/install/CentOS-6.x/install_CPAN.sh
	-> script/linux/install/CentOS-6.x/install_CMAKE.sh
	-> script/linux/install/CentOS-6.x/install_XERCES.sh
	-> script/linux/install/CentOS-6.x/install_DOXYGEN.sh
	-> script/linux/install/CentOS-6.x/install_BOOST.sh
	-> script/linux/install/CentOS-6.x/install_GO.sh
	-> script/linux/install/CentOS-6.x/install_GRPC.sh	
	-> script/linux/install/CentOS-6.x/install_OSPL.sh
	
# ---------------------------------------------------------------------------- #
# 					III - VESA Libraries [required if VESA]                    #
# ---------------------------------------------------------------------------- #

	-> script/linux/install/CentOS-6.x/install_OSG.sh
	-> script/linux/install/CentOS-6.x/install_SILVERLINING.sh
	-> script/linux/install/CentOS-6.x/install_TRITON.sh
	
# ---------------------------------------------------------------------------- #
# 					IV - QT + IDE [optionnal but strongly recommanded]         #
# ---------------------------------------------------------------------------- #

	-> script/linux/install/CentOS-6.x/install_QT.sh
	-> script/linux/install/CentOS-6.x/install_QTCREATOR.sh
		
# ---------------------------------------------------------------------------- #
#						V - VR Libraries [optionnal]                           #
# ---------------------------------------------------------------------------- #

	-> script/linux/install/CentOS-6.x/install_OPENCV.sh
	-> script/linux/install/CentOS-6.x/install_HIDAPI.sh
	-> script/linux/install/CentOS-6.x/install_JSONCPP.sh
	-> script/linux/install/CentOS-6.x/install_VRPN.sh
	-> script/linux/install/CentOS-6.x/install_OSVR_LIBFUNCTIONALITY.sh
	-> script/linux/install/CentOS-6.x/install_OSVR_CORE.sh
	-> script/linux/install/CentOS-6.x/install_OSVR_TRACKER.sh
	-> script/linux/install/CentOS-6.x/install_OSVR_DISPLAY.sh

# ---------------------------------------------------------------------------- #
# 							VI - CEGUI [reaaaally optionnal]                   #
# ---------------------------------------------------------------------------- #

	-> [unstable as a fuck] script/linux/install/CentOS-6.x/install_CEGUI.sh
	-> [unstable as a fuck] script/linux/install/CentOS-6.x/install_CEED.sh

# EOF