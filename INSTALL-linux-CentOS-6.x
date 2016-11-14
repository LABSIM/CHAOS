# ======================================================================== #
# Installation script execution order
# ======================================================================== #

----------------------------------------------------------------------------
I - Package (YUM)
----------------------------------------------------------------------------

	-> [sudo required] script/linux/install/CentOS-6.x/install_Dependencies.sh

----------------------------------------------------------------------------
II - Libraries
----------------------------------------------------------------------------

	-> script/linux/install/CentOS-6.x/install_PERL.sh	
	-> script/linux/install/CentOS-6.x/install_CPAN.sh
	-> script/linux/install/CentOS-6.x/install_CMAKE.sh
	-> script/linux/install/CentOS-6.x/install_XERCES.sh
	-> script/linux/install/CentOS-6.x/install_DOXYGEN.sh
	-> script/linux/install/CentOS-6.x/install_GLM.sh
	-> script/linux/install/CentOS-6.x/install_GLFW.sh
	-> script/linux/install/CentOS-6.x/install_QT.sh
	-> script/linux/install/CentOS-6.x/install_BOOST.sh
	-> script/linux/install/CentOS-6.x/install_OSG.sh
	-> script/linux/install/CentOS-6.x/install_SILVERLINING.sh
	-> script/linux/install/CentOS-6.x/install_TRITON.sh
	-> script/linux/install/CentOS-6.x/install_OPENCV.sh
	-> script/linux/install/CentOS-6.x/install_HIDAPI.sh
	-> script/linux/install/CentOS-6.x/install_JSONCPP.sh
	-> script/linux/install/CentOS-6.x/install_OSVR_LIBFUNCTIONALITY.sh
	-> script/linux/install/CentOS-6.x/install_OSVR_CORE.sh
	-> script/linux/install/CentOS-6.x/install_OSVR_TRACKER.sh
	-> script/linux/install/CentOS-6.x/install_OSPL.sh
	-> script/linux/install/CentOS-6.x/install_CEGUI.sh

----------------------------------------------------------------------------
III - IDE
----------------------------------------------------------------------------

	-> script/linux/install/CentOS-6.x/install_QTCREATOR.sh
	-> [unstable as a fuck] script/linux/install/CentOS-6.x/install_CEED.sh
