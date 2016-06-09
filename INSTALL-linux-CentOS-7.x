# ======================================================================== #
# Installation script execution order

-> [sudo required] script/linux/install/CentOS-7.x/install_Dependencies.sh
-> [root] script/linux/install/CentOS-7.x/pre-configure_GCC.sh
-> script/linux/install/CentOS-7.x/install_GCC.sh
-> [root] script/linux/install/CentOS-7.x/post-configure_GCC.sh
-> run script/linux/switch_environment.sh with your corresponding environment
-> script/linux/install/CentOS-7.x/install_CMAKE.sh
-> script/linux/install/CentOS-7.x/install_XERCES.sh
-> script/linux/install/CentOS-7.x/install_DOXYGEN.sh
-> script/linux/install/CentOS-7.x/install_GLM.sh
-> script/linux/install/CentOS-7.x/install_GLFW.sh
-> script/linux/install/CentOS-7.x/install_QT.sh
-> script/linux/install/CentOS-7.x/install_QTCREATOR.sh
-> script/linux/install/CentOS-7.x/install_BOOST.sh
-> script/linux/install/CentOS-7.x/install_OSG.sh
-> script/linux/install/CentOS-7.x/install_SILVERLINING.sh
-> script/linux/install/CentOS-7.x/install_TRITON.sh
-> [root] script/linux/install/CentOS-7.x/pre-configure_OSPL.sh
-> script/linux/install/CentOS-7.x/install_OSPL.sh
