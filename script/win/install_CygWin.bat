@echo off&SetLocal EnableDelayedExpansion
rem
rem ----------------------------------------------------------
rem 
rem install_CygWin.bat for Windows Seven Pro 64 Bits
rem Version : 1.0
rem Date : 23/12/2013
rem Author : Christian Schulte 
rem Configures and installs CygWin
rem
rem ----------------------------------------------------------
rem 
rem Le fichier setup.ini contenu dans le repository local d'installation
rem a ete modifie afin de passer toutes les dependances dans la category
rem Base.
rem Cette modification est necessaire afin de pouvoir faire une installation
rem complete silencieuse.
rem 
rem Le script utilise est : 
rem 	sed -i -e "s/[cC]ategory:.*/category: Base/g" setup.ini
rem
echo.
echo ----------------------------------------------------------
echo.
echo Install of CygWin
if not exist c:\DevEnv (
	echo. 
	echo ----------------------------------------------------------
	echo Please execute first createDevEnv.bat
	goto end
)	
echo.
if not exist C:\DevEnv\Boost-1.53.0 (
	echo. 
	echo ----------------------------------------------------------
	echo Please execute first install_boost.bat
	goto end
)	
echo.
if not exist C:\DevEnv\CEGui-0.8.2 (
	echo. 
	echo ----------------------------------------------------------
	echo Please execute first install_cegui.bat
	goto end
)	
if not exist C:\DevEnv\OSG-3.2.0 (
	echo. 
	echo ----------------------------------------------------------
	echo Please execute first install_OSG.bat
	goto end
)	
echo.
echo ----------------------------------------------------------
echo Installation of CygWin
cd Applications
setup-x86.exe --local-install --local-package-dir z:\CygWin --quiet-mode --no-shortcuts >NUL 2>&1
echo ----------------------------------------------------------
echo Modification of /etc/profile
sed -i -e "47,50d" c:\cygwin\etc\profile
rem La modification au dessus provoque des fin de ligne windows... faut reconvertir le fichier...
c:\cygwin\bin\dos2unix.exe c:/cygwin/etc/profile > NUL 2>&1
echo ----------------------------------------------------------
echo Modification of Cygwin.bat
sed -i -e "5iset LANG=fr_FR.UTF-16" c:\cygwin\Cygwin.bat
cd ..
:end
echo ----------------------------------------------------------
echo. 
