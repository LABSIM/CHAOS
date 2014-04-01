@echo off&SetLocal EnableDelayedExpansion
rem
rem ----------------------------------------------------------
rem 
rem install_DDS.bat for Windows Seven Pro 64 Bits
rem Version : 1.1
rem Date : 23/12/2013
rem Author : Christian Schulte 
rem Configures and installs : 
rem       - OpenFusion TAO 1.6.1
rem       - OpenSplice DDS V5.5.1
rem       - Simple DDS 1.0
rem
rem ----------------------------------------------------------
rem 
echo.
echo ----------------------------------------------------------
echo.
echo Install of DDS Environment
if not exist c:\DevEnv (
	echo. 
	echo ----------------------------------------------------------
	echo Please execute first createDevEnv.bat
	goto end
)	
if not exist C:\DevEnv\Boost-1.53.0 (
	echo. 
	echo ----------------------------------------------------------
	echo Please execute first install_boost.bat
	goto end
)	
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
if not exist c:\cygwin (
	echo. 
	echo ----------------------------------------------------------
	echo Please execute first install_CygWin.bat
	goto end
)
echo.
echo ----------------------------------------------------------
echo Extraction/Installation of OpenFusion TAO   version 1.6.1
cd Applications
7z.exe x -y TAO161_0-Windows-vc10-inline-32bit-110704.zip -oc:\DevEnv\OpenFusionTAO-1.6.1 > NUL
cd ..
echo ----------------------------------------------------------
echo Creating TAO_ROOT environment variable
SetEnv -au TAO_ROOT %%c:\DevEnv\OpenFusionTAO-1.6.1
echo ----------------------------------------------------------
echo Extraction/Installation of OpenSplice DDS   version 5.5.1
c:
cd c:\DevEnv
bsdtar -xzf z:\Applications\OpenSpliceDDSV5.5.1-src.tar.gz > NUL
echo ----------------------------------------------------------
echo Correction of checkconf file
rem Correction du path vers le compilateur C#
sed -i -e "s#/cygdrive/$MAIN_DRIVE/Program Files/Microsoft SDKs/Windows/v6.0A/bin#/cygdrive/$MAIN_DRIVE/Program Files (x86)/Microsoft SDKs/Windows/v8.0A/bin/NETFX 4.0 Tools#g" c:\DevEnv\OpenSplice\bin\checkconf
rem Correction des path vers le compilateur c/c++
sed -i -e "169s#\$CL_EXE#\"\$CL_EXE\"#" c:\DevEnv\OpenSplice\bin\checkconf
sed -i -e "170s#\$VS_HOME#\"\$VS_HOME\"#" c:\DevEnv\OpenSplice\bin\checkconf
sed -i -e "171s#\$VS_HOME#\"\$VS_HOME\"#" c:\DevEnv\OpenSplice\bin\checkconf
rem Inscription en dur de la version du compilateur
sed -i -e "191i    COMPILER_VER=17.00.50727.1" c:\DevEnv\OpenSplice\bin\checkconf
rem Insertion des variables d'environnement pour le compilateur Visual
	rem Creation d'un fichier temporaire contenant le texte a inserer sur plusieures lignes
echo     if [ $CL_MAJOR = 17 ]> tmpfile.tmp
echo     then>> tmpfile.tmp
echo 	     COMPILER_VER="VS .NET 2012 (Visual Studio 11)">> tmpfile.tmp
echo         LIB="$DOS_CONV_PATH\VC\LIB;">> tmpfile.tmp"
echo         SDK_DIR="$UNIX_CONV_PATH/../Microsoft SDKs/Windows/v8.0A">> tmpfile.tmp
echo         FrameworkSDKDir=`cygpath -u "$SDK_DIR"`>> tmpfile.tmp
echo         PATH="$FrameworkSDKDir/bin:$PATH">> tmpfile.tmp
echo         set_var FrameworkSDKDir "$FrameworkSDKDir">> tmpfile.tmp
echo         set_var LIBPATH "$LIBPATH">> tmpfile.tmp
echo         set_var LIB "$LIB">> tmpfile.tmp
echo     fi>> tmpfile.tmp
	rem Insertion de ce fichier temporaire dans le fichier d'origine
sed -i -e "243r tmpfile.tmp" c:\DevEnv\OpenSplice\bin\checkconf
	rem Suppression du fichier temporaire
rm -f tmpfile.tmp
rem Correction de la creation de la major version de make
	rem Suppression de l'ancienne ligne
sed -i -e "353d" c:\DevEnv\OpenSplice\bin\checkconf
	rem Insertion de la nouvelle ligne
sed -i -e "353i    MAKE_MAJOR=`make -v 2>/dev/null | head -1 | cut -f 3 -d ' ' | cut -f 1 -d .`" c:\DevEnv\OpenSplice\bin\checkconf
rem Correction de la creation de la minor version de make
	rem Suppression de l'ancienne ligne
sed -i -e "360d" c:\DevEnv\OpenSplice\bin\checkconf
	rem Insertion de la nouvelle ligne
sed -i -e "360i    MAKE_MINOR=`make -v 2>/dev/null | head -1 | cut -f 3 -d ' ' | cut -f 2 -d .`" c:\DevEnv\OpenSplice\bin\checkconf
rem Suppression de tous les fichiers sedXXXX temporaires crees lors des modifs
rm -f sed*
echo ----------------------------------------------------------
echo Correction of winln makefile
rem Insertion des variables d'environnement pour le compilateur Visual
	rem Creation d'un fichier temporaire contenant le texte a inserer sur plusieures lignes
echo ifeq ("$(VS_VER)","17")> tmpfile.tmp
echo VS_INCLUDE += -I"$(VS_HOME)/VC/include" -I"$(VS_HOME)/../Microsoft SDKs/Windows/v8.0A/Include"  -I"$(WINDOWSSDKDIR)/Include/shared" -I"$(WINDOWSSDKDIR)/Include/um" -I"$(WINDOWSSDKDIR)/Include/winrt">> tmpfile.tmp
echo VS_LIBS = -L"$(VS_HOME)/VC/lib" -L"$(VS_HOME)/../Microsoft SDKs/Windows/v8.0A/lib"  -L"$(WINDOWSSDKDIR)/Lib/win8/um/x86">> tmpfile.tmp
echo endif>> tmpfile.tmp
echo.>> tmpfile.tmp
	rem Insertion de ce fichier temporaire dans le fichier d'origine
sed -i -e "10r tmpfile.tmp" c:\DevEnv\OpenSplice\setup\wrappers\winln\makefile
	rem Suppression du fichier temporaire
rm -f tmpfile.tmp
rem Suppression de tous les fichiers sedXXXX temporaires crees lors des modifs
rm -f sed*
echo ----------------------------------------------------------
echo Correction of x86.win32-default.mak
rem Insertion des variables d'environnement pour le compilateur Visual
	rem Creation d'un fichier temporaire contenant le texte a inserer sur plusieures lignes
echo ifeq ("$(VS_VER)","17")>tmpfile.tmp
echo    VS_INCLUDE =  -I"$(VS_HOME)/VC/include">>tmpfile.tmp
echo    VS_INCLUDE += -I"$(VS_HOME)/../Microsoft SDKs/Windows/v8.0A/include"  -I"$(WINDOWSSDKDIR)/Include/shared" -I"$(WINDOWSSDKDIR)/Include/um" -I"$(WINDOWSSDKDIR)/Include/winrt" -I"/cygdrive/c/DevEnv/include">>tmpfile.tmp
echo.>>tmpfile.tmp
echo    VS_LIB_FLAGS  = -L"$(VS_HOME)/VC/lib">>tmpfile.tmp
echo    VS_LIB_FLAGS += -L"$(VS_HOME)/../Microsoft SDKs/Windows/v8.0A/lib" -L"$(WINDOWSSDKDIR)/Lib/win8/um/x86" -L"/cygdrive/c/DevEnv/lib" -L"/cygdrive/c/DevEnv/CEGui-0.8.2/dependencies/lib/dynamic">>tmpfile.tmp
echo endif>>tmpfile.tmp
echo.>>tmpfile.tmp
	rem Insertion de ce fichier temporaire dans le fichier d'origine
sed -i -e "85r tmpfile.tmp" c:\DevEnv\OpenSplice\setup\x86.win32-default.mak
	rem Suppression du fichier temporaire
rm -f tmpfile.tmp
rem Suppression de tous les fichiers sedXXXX temporaires crees lors des modifs
rm -f sed*
echo ----------------------------------------------------------
echo Creating DDS environment variables
SetEnv -au SPLICE_ORB DDS_OpenFusion_1_6_1
set SPLICE_ORB=DDS_OpenFusion_1_6_1
SetEnv -au OSPL_HOME %%c:\DevEnv\OpenSpliceDDS-5.5.1\HDE\x86.win32
set OSPL_HOME=c:\DevEnv\OpenSpliceDDS-5.5.1\HDE\x86.win32
SetEnv -au OSPL_TARGET x86.win32
set OSPL_TARGET=x86.win32
SetEnv -au PATH %%c:\DevEnv\OpenSpliceDDS-5.5.1\HDE\x86.win32\bin;c:\DevEnv\OpenSpliceDDS-5.5.1\HDE\x86.win32\lib;c:\DevEnv\OpenSpliceDDS-5.5.1\HDE\x86.win32\examples\lib
SetEnv -au OSPL_TMPL_PATH %%c:\DevEnv\OpenSpliceDDS-5.5.1\HDE\x86.win32\etc\idlpp
echo ----------------------------------------------------------
echo.
echo 	End of Script
echo    Follow the written procedure in order to 
echo    configure and install OpenSpliceDDS-5.5.1
:end
echo. 
echo ----------------------------------------------------------
echo. 
