@echo off&SetLocal EnableDelayedExpansion
rem
rem ----------------------------------------------------------
rem 
rem install_OSG.bat for Windows Seven Pro 64 Bits
rem Version : 1.1
rem Date : 07/10/2013
rem Author : Christian Schulte 
rem Configures and installs OpenSceneGraph 3.2.0
rem
rem ----------------------------------------------------------
rem 
echo.
echo ----------------------------------------------------------
echo.
echo Install of OpenSceneGraph 3.2.0
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
echo.
echo ----------------------------------------------------------
echo Extraction of OpenSceneGraph                version 3.2.0
cd Applications
7z.exe x -y OpenSceneGraph-3.2.0.zip -oc:\DevEnv > NUL
cd ..
echo ----------------------------------------------------------
echo Configuration of OpenSceneGraph             version 3.2.0
c:
cd c:\DevEnv\OpenSceneGraph-3.2.0
cmake -Wno-dev -DCMAKE_INSTALL_PREFIX=c:\DevEnv\OSG-3.2.0 ^
 -G "Visual Studio 11" ^
 -DCMAKE_CONFIGURATION_TYPES=Release ^
 -DZLIB_INCLUDE_DIR=C:\DevEnv\CEGui-0.8.2\dependencies\include ^
 -DZLIB_LIBRARY=C:\DevEnv\CEGui-0.8.2\dependencies\lib\dynamic\zlib.lib ^
 -DPNG_PNG_INCLUDE_DIR=c:\DevEnv\CEGui-0.8.2\dependencies\include ^
 -DPNG_LIBRARY=c:\DevEnv\CEGui-0.8.2\dependencies\lib\dynamic\libpng.lib ^
 -DJPEG_INCLUDE_DIR=c:\DevEnv\CEGui-0.8.2\dependencies\include ^
 -DJPEG_LIBRARY=c:\DevEnv\CEGui-0.8.2\dependencies\lib\dynamic\jpeg.lib ^
 -DTIFF_INCLUDE_DIR=c:\DevEnv\include ^
 -DTIFF_LIBRARY=c:\DevEnv\lib\libtiff.lib ^
 . > c:\DevEnv\osg_cmake.log 2>&1
echo ----------------------------------------------------------
echo Please compile and install in Release with Visual
echo Press any key to continue...
pause
cd ..
y:
echo ----------------------------------------------------------
echo Adding c:\DevEnv\OSG-3.2.0\bin to PATH
set "str=%PATH%"
if "!str:c:\DevEnv\OSG-3.2.0\bin=!" EQU "%str%" (
  	SetEnv -au PATH %%c:\DevEnv\OSG-3.2.0\bin
)
echo ----------------------------------------------------------
echo Adding c:\DevEnv\OSG-3.2.0\bin to LIBRARY_PATH
set "str=%LIBRARY_PATH%"
if "!str:c:\DevEnv\OSG-3.2.0\bin=!" EQU "%str%" (
  	SetEnv -au LIBRARY_PATH %%c:\DevEnv\OSG-3.2.0\bin
)
echo ----------------------------------------------------------
echo Adding c:\DevEnv\OSG-3.2.0\lib to LIBRARY_PATH
if "!str:c:\DevEnv\OSG-3.2.0\lib=!" EQU "%str%" (
  	SetEnv -au LIBRARY_PATH %%c:\DevEnv\OSG-3.2.0\lib
)
echo ----------------------------------------------------------
echo Adding c:\DevEnv\OSG-3.2.0 to OSG_ROOT
SetEnv -au OSG_ROOT %%c:\DevEnv\OSG-3.2.0
echo ----------------------------------------------------------
echo Adding 3.2.0 to OSG_VERSION
SetEnv -au OSG_VERSION 3.2.0 
echo ----------------------------------------------------------
echo Removing temporary folder
rm -rf c:\DevEnv\OpenSceneGraph-3.2.0
:end
echo ----------------------------------------------------------
echo. 
