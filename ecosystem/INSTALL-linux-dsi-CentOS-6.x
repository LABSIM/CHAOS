# ---------------------------------------------------------------------------- #
# 						I - Package (YUM) [required]						   #
# ---------------------------------------------------------------------------- #

	-> [sudo required] script/linux/install/CentOS-6.x/install_Dependencies.sh


# ---------------------------------------------------------------------------- #
# 						     II - GNU  :) [required]						   #
# ---------------------------------------------------------------------------- #

	-> script/linux/install/CentOS-6.x/install_BINUTILS.sh
	-> script/linux/install/CentOS-6.x/install_GMP.sh	
	-> script/linux/install/CentOS-6.x/install_MPFR.sh	
	-> script/linux/install/CentOS-6.x/install_MPC.sh	
	-> script/linux/install/CentOS-6.x/install_AUTOGEN.sh		
	-> script/linux/install/CentOS-6.x/install_ISL.sh
	-> script/linux/install/CentOS-6.x/install_GCC.sh	
	-> script/linux/install/CentOS-6.x/install_GDB.sh	
	
# ---------------------------------------------------------------------------- #
# 					  III - Common Libraries [required]                         #
# ---------------------------------------------------------------------------- #

	-> script/linux/install/CentOS-6.x/install_PERL.sh	
	-> script/linux/install/CentOS-6.x/install_CPAN.sh	
	-> script/linux/install/CentOS-6.x/install_CMAKE.sh
	-> script/linux/install/CentOS-6.x/install_XERCES.sh
	-> script/linux/install/CentOS-6.x/install_DOXYGEN.sh
	-> script/linux/install/CentOS-6.x/install_BOOST.sh

# ---------------------------------------------------------------------------- #
# 				    	   IV - QT + IDE [optionnal]         				   #
# ---------------------------------------------------------------------------- #

	-> script/linux/install/CentOS-6.x/install_QT.sh
	-> script/linux/install/CentOS-6.x/install_QTCREATOR.sh

# ---------------------------------------------------------------------------- #
# 				    V - Image Generator Libraries [optionnal]                  #
# ---------------------------------------------------------------------------- #

	-> script/linux/install/CentOS-6.x/install_OSG.sh
	-> script/linux/install/CentOS-6.x/install_SILVERLINING.sh
	-> script/linux/install/CentOS-6.x/install_TRITON.sh
			
# ---------------------------------------------------------------------------- #
# 					 VI - Simulation Libraries [optional]         			   #
# ---------------------------------------------------------------------------- #

	-> script/linux/install/CentOS-6.x/install_GRPC.sh
	-> script/linux/install/CentOS-6.x/install_OSPL.sh
	
# ---------------------------------------------------------------------------- #
#				      VII - VR Libraries [optionnal]                           #
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
# 					 VIII - CEGUI [reaaaally optionnal]                        #
# ---------------------------------------------------------------------------- #

	-> [unstable as a fuck] script/linux/install/CentOS-6.x/install_CEGUI.sh
	-> [unstable as a fuck] script/linux/install/CentOS-6.x/install_CEED.sh

# EOF