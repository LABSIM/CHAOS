@echo off&SetLocal EnableDelayedExpansion
rem
rem ----------------------------------------------------------
rem 
rem install_SimpleDDS.bat for Windows Seven Pro 64 Bits
rem Version : 1.1
rem Date : 23/12/2013
rem Author : Christian Schulte 
rem Configures and installs Simple DDS 0.10
rem
rem ----------------------------------------------------------
rem 
echo.
echo ----------------------------------------------------------
echo.
echo Install of Simple DDS 0.10
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
if not exist c:\DevEnv\OpenFusionTAO-1.6.1 (
	echo. 
	echo ----------------------------------------------------------
	echo Please execute first install_DDS.bat
	goto end
)
if not exist c:\DevEnv\OpenSpliceDDS-5.5.1 (
	echo. 
	echo ----------------------------------------------------------
	echo Please configure and install OpenSpliceDDS
	goto end
)
echo ----------------------------------------------------------
echo Extraction of Simple DDS                    version 0.10
c:
cd c:\DevEnv\
bsdtar -xzf z:\Applications\simd-cxx-src-v0.10.tar.gz > NUL
echo ----------------------------------------------------------
echo Adding OpenSplice version in config.hpp
cd simd-cxx
rem Ecriture du texte a inserer dans un fichier temporaire
echo //////////////////////////////////////////////////////////////////////////////>tmpfile.tmp
echo // OSPL Version>>tmpfile.tmp
echo //////////////////////////////////////////////////////////////////////////////>>tmpfile.tmp
echo #define SIMD_OSPL_MAJ_VER VALEUR>>tmpfile.tmp
echo #define SIMD_OSPL_MIN_VER VALEUR>>tmpfile.tmp
echo #define SIMD_OSPL_REVISION VALEUR>>tmpfile.tmp
echo.>>tmpfile.tmp
rem Insertion de ce fichier dans le fichier d'origine
sed -i -e "3r tmpfile.tmp" .\src\dds\config.hpp
rem Suppression du fichier temporaire
rm -f tmpfile.tmp
rem Remplacement du mot VALEUR par le bon numero
rem on put pas le faire dans les echo directement car c'est 
rem interprete comme une redirection de flux
sed -i -e "7,8s/VALEUR/5/" .\src\dds\config.hpp
sed -i -e "9s/VALEUR/1/" .\src\dds\config.hpp
echo ----------------------------------------------------------
echo Correction of DomainParticipant init in domain.cpp
rem Ecriture du texte a inserer dans un fichier temporaire
echo DDS::DomainParticipant* dp;>tmpfile.tmp
echo #if (SIMD_OSPL_MAJ_VER INFERIEUR 6)>>tmpfile.tmp
echo 	dp = dpfFLECHEcreate_participant("",>>tmpfile.tmp
echo 	                  PARTICIPANT_QOS_DEFAULT,>>tmpfile.tmp
echo 	                  0,>>tmpfile.tmp
echo 	                  DDS::ANY_STATUS);>>tmpfile.tmp
echo #else>>tmpfile.tmp
echo 	dp = dpfFLECHEcreate_participant(0,>>tmpfile.tmp
echo 	               PARTICIPANT_QOS_DEFAULT,>>tmpfile.tmp
echo 	               0,>>tmpfile.tmp
echo 	               DDS::ANY_STATUS);>>tmpfile.tmp
echo #endif>>tmpfile.tmp
echo.>>tmpfile.tmp 
rem Insertion de ce fichier dans le fichier d'origine
sed -i -e "37r tmpfile.tmp" .\src\dds\domain.cpp
rem Suppression du fichier temporaire
rm -f tmpfile.tmp
rem Remplacement des mots FLECHE et INFERIEUR par les bons symboles
rem on put pas le faire dans les echo directement car c'est 
rem interprete comme des redirections de flux
sed -i -e "39s/INFERIEUR/</" .\src\dds\domain.cpp
sed -i -e "40,45s/FLECHE/->/" .\src\dds\domain.cpp
rem Mise en commentaire de l'ancien code
sed -i -e "51s#  DDS#/\*  DDS#" .\src\dds\domain.cpp
sed -i -e "55s#;#;\*/#" .\src\dds\domain.cpp
echo ----------------------------------------------------------
echo Adding warning disable to domain.hpp and waitset.hpp
rem Ecriture du texte a inserer dans un fichier temporaire
echo #if (_MSC_VER)>tmpfile.tmp
echo #	pragma warning(disable:4275) // Disable informational warning : non DLL-interface classkey 'identifier' used as base for DLL-interface classkey 'identifier' : An exported class was derived from a class that was not exported>>tmpfile.tmp
echo #endif>>tmpfile.tmp
rem Insertion de ce fichier dans le fichier d'origine
sed -i -e "4r tmpfile.tmp" .\src\dds\domain.hpp
sed -i -e "4r tmpfile.tmp" .\src\dds\waitset.hpp
rem Suppression du fichier temporaire
rm -f tmpfile.tmp sed*
echo ----------------------------------------------------------
echo Copy of cmake module files 
cp z:\tmp\*.cmake .\cmake
echo ----------------------------------------------------------
echo Modification of boost shared_ptr.hpp
rem Mise en commentaire de l'operateur [] incompatible avec SimpleDDS...
sed -i -e "658s#typename#/\*typename#" C:\DevEnv\Boost-1.53.0\include\boost-1_53\boost\smart_ptr\shared_ptr.hpp
sed -i -e "664s#\}#\}\*/#" C:\DevEnv\Boost-1.53.0\include\boost-1_53\boost\smart_ptr\shared_ptr.hpp
echo ----------------------------------------------------------
echo Configuration of Simple DDS                 version 0.10
mkdir build
cd build
cmake -Wno-dev -DCMAKE_INSTALL_PREFIX=c:\DevEnv\SimpleDDS-0.10 ^
 -G "Visual Studio 11" ^
 -DCMAKE_CONFIGURATION_TYPES=Release ^
 .. > c:\DevEnv\SimD_cmake.log 2>&1
echo ----------------------------------------------------------
echo Please compile and install in Release with Visual
echo Press any key to continue...
pause
cd ../..
z:
echo ----------------------------------------------------------
echo Adding Simple DDS to PATH
set "str=%PATH%"
if "!str:c:\DevEnv\SimpleDDS-0.10\lib=!" EQU "%str%" (
  	SetEnv -au PATH %%c:\DevEnv\SimpleDDS-0.10\lib
)
echo ----------------------------------------------------------
echo Remove temporary folder
rm -rf c:\DevEnv\simd-cxx
