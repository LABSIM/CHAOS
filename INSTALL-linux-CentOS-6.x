# ======================================================================== #
# Installation script execution order
# ======================================================================== #

# Libraries

-> [sudo required] bin/install/linux/linux-CentOS-6.x/install_Dependencies.sh
-> run script/linux/switch_environment.sh with your corresponding environment
-> bin/install/linux/linux-CentOS-6.x/install_CMAKE.sh
-> bin/install/linux/linux-CentOS-6.x/install_XERCES.sh
-> bin/install/linux/linux-CentOS-6.x/install_DOXYGEN.sh
-> bin/install/linux/linux-CentOS-6.x/install_GLM.sh
-> bin/install/linux/linux-CentOS-6.x/install_GLFW.sh
-> bin/install/linux/linux-CentOS-6.x/install_QT.sh
-> bin/install/linux/linux-CentOS-6.x/install_BOOST.sh
-> bin/install/linux/linux-CentOS-6.x/install_OSG.sh
-> bin/install/linux/linux-CentOS-6.x/install_SILVERLINING.sh
-> bin/install/linux/linux-CentOS-6.x/install_TRITON.sh
-> bin/install/linux/linux-CentOS-6.x/install_OSPL.sh
-> bin/install/linux/linux-CentOS-6.x/install_CEGUI.sh

# IDE

-> bin/install/linux/linux-CentOS-6.x/install_QTCREATOR.sh
-> bin/install/linux/linux-CentOS-6.x/install_CEED.sh
-> bin/install/linux/linux-CentOS-6.x/install_ECLIPSE.sh
-> bin/install/linux/linux-CentOS-6.x/install_ATOM.sh

# Software

-> bin/install/linux/linux-CentOS-6.x/install_FIREFOX.sh
