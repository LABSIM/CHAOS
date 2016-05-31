# ======================================================================== #
# Installation script execution order

-> [sudo required] bin/install/linux/linux-CentOS-6.x/install_Dependencies.sh
-> [root] bin/install/linux/linux-CentOS-6.x/pre-configure_GCC.sh
-> bin/install/linux/linux-CentOS-6.x/install_GCC.sh
-> [root] bin/install/linux/linux-CentOS-6.x/post-configure_GCC.sh
-> run script/linux/switch_environment.sh with your corresponding environment
-> bin/install/linux/linux-CentOS-6.x/install_CMAKE.sh
-> bin/install/linux/linux-CentOS-6.x/install_XERCES.sh
-> bin/install/linux/linux-CentOS-6.x/install_DOXYGEN.sh
-> bin/install/linux/linux-CentOS-6.x/install_GLM.sh
-> bin/install/linux/linux-CentOS-6.x/install_GLFW.sh
-> bin/install/linux/linux-CentOS-6.x/install_QT.sh
-> bin/install/linux/linux-CentOS-6.x/install_QTCREATOR.sh
-> bin/install/linux/linux-CentOS-6.x/install_BOOST.sh
-> bin/install/linux/linux-CentOS-6.x/install_OSG.sh
-> bin/install/linux/linux-CentOS-6.x/install_SILVERLINGIN.sh
-> [root] bin/install/linux/linux-CentOS-6.x/pre-configure_TRITON.sh
-> bin/install/linux/linux-CentOS-6.x/install_TRITON.sh
-> [root] bin/install/linux/linux-CentOS-6.x/pre-configure_OSPL.sh
-> bin/install/linux/linux-CentOS-6.x/install_OSPL.sh