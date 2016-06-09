@echo off&SetLocal EnableDelayedExpansion
rem
rem ----------------------------------------------------------
rem 
rem install_Boost.bat for Windows Seven Pro 64 Bits
rem Version : 1.0
rem Date : 03/10/2013
rem Author : Christian Schulte 
rem Configures and installs boost 1.53.0
rem
rem ----------------------------------------------------------
rem 
echo.
echo ----------------------------------------------------------
echo.
echo Install of Boost 1.53.0
if not exist c:\DevEnv (
	echo. 
	echo ----------------------------------------------------------
	echo Please execute first createDevEnv.bat
	goto end
)
echo.
echo ----------------------------------------------------------
echo Extraction of Boost                        version 1.53.0
cd Applications
7z.exe x -y boost_1_53_0.7z -oc:\DevEnv > NUL
cd ..
echo ----------------------------------------------------------
echo Configuration of bootstrap                 version 1.53.0
c:
cd c:\DevEnv\boost_1_53_0
if exist (c:\DevEnv\bin\gcc.exe) (
    echo Installation avec gcc
	rem marcherait aussi avec mingw au lieu de gcc, mais c'est plus global comme ça
	set TOOLSET=gcc
) else (
    echo Installation avec msvc
	set TOOLSET=msvc
	echo Correction du build.bat
	cd tools\build\v2\engine
	sed -i -e "s/GZ/RTC1/g" build.bat
	sed -i -e "s# /MLd##g" build.bat
	cd ../../../..
)

call bootstrap.bat %TOOLSET% > NUL
if (%TOOLSET%=="gcc") (
	echo ----------------------------------------------------------
	echo Modification of project-config.jam
	rem non obligatoire mais evite des test inutiles de compilateur lors du bjam
	sed -i -e "s/msvc/gcc/g" project-config.jam
)
echo ----------------------------------------------------------
echo Modification of user-config.jam
cd tools\build\v2
rem pour prise en compte du path de python
echo using python : : c:\\DevEnv\\Python\\python ;  # use for most toolsets >> user-config.jam
echo. >> user-config.jam
echo ----------------------------------------------------------
echo Modification of python.jam
cd tools
rem voir http://stackoverflow.com/questions/1704046/boostpython-windows-7-64-bit
sed -i -e "480,487d" python.jam
cd ../../../..
echo ----------------------------------------------------------
echo Compilation and installation of Boost      version 1.53.0
rem Le --without-context est dû au manque du compilateur assembleur ML sur WIN7 sans Visual... on pourrait l'installer, mais c'est un peu galère et pas utile tant que l'n n'a pas besoin de context
rem Le --debug-configuration est pour avoir un log plus conséquent pour voir les soucis python
rem Le --layout=system permet de créer des noms de lib SANS le compilo et la version boost (gcc)
rem LE --layout=versioned permet de créer des noms de lib AVEC le compilo et la version boost (visual obligatoire)
bjam --prefix="c:\DevEnv\Boost-1.53.0" ^
     --layout=versioned ^
	 --debug-configuration ^
	 --without-context ^
	 toolset=%TOOLSET% ^
	 variant=release,debug ^
	 link=shared ^
	 threading=multi ^
	 runtime-link=shared ^
	 -j 4 ^
	 install ^
	 >c:\DevEnv\boost_install.log ^
	 2>&1
cd ..
z:
echo ----------------------------------------------------------
echo Remove temporary folder
rm -rf c:\DevEnv\boost_1_53_0
echo ----------------------------------------------------------
echo Adding c:\DevEnv\Boost-1.53.0\lib to PATH
set "str=%PATH%"
if "!str:c:\DevEnv\Boost-1.53.0\lib=!" EQU "%str%" (
  	SetEnv -au PATH %%c:\DevEnv\Boost-1.53.0\lib
)
echo ----------------------------------------------------------
echo Adding c:\DevEnv\Boost-1.53.0\lib to LIBRARY_PATH
set "str=%LIBRARY_PATH%"
if "!str:c:\DevEnv\Boost-1.53.0\lib=!" EQU "%str%" (
  	SetEnv -au LIBRARY_PATH %%c:\DevEnv\Boost-1.53.0\lib
)
echo ----------------------------------------------------------
echo Adding c:\DevEnv\Boost-1.53.0\ to BOOST_ROOT
SetEnv -au BOOST_ROOT %%c:\DevEnv\Boost-1.53.0
echo ----------------------------------------------------------
echo Adding c:\DevEnv\Boost-1.53.0\ to BOOST_DIR
SetEnv -au BOOST_DIR %%c:\DevEnv\Boost-1.53.0 
echo ----------------------------------------------------------
echo Adding 1.53.0 to BOOST_VERSION
SetEnv -au BOOST_VERSION 1.53.0 
:end
echo. 
echo ----------------------------------------------------------
echo. 
