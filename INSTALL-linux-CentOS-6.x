# ======================================================================== #
# Installation script execution order
# ======================================================================== #

----------------------------------------------------------------------------
I - Package (YUM)
----------------------------------------------------------------------------

	-> [sudo required] script/linux/install/CentOS-6.x/install_Dependencies.sh

----------------------------------------------------------------------------
II - Boostrapping (should log some error message untill all script are executed)
----------------------------------------------------------------------------

	-> script/linux/switch_environment.sh [with your corresponding environment here]

----------------------------------------------------------------------------
III - Libraries
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
	-> script/linux/install/CentOS-6.x/install_OSPL.sh
	-> script/linux/install/CentOS-6.x/install_CEGUI.sh

----------------------------------------------------------------------------
IV - IDE
----------------------------------------------------------------------------

	-> script/linux/install/CentOS-6.x/install_QTCREATOR.sh
	-> [unstable as a fuck] script/linux/install/CentOS-6.x/install_CEED.sh
