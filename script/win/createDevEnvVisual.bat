@echo off&SetLocal EnableDelayedExpansion
if "%1"=="--help" goto help
if "%1"=="-h" goto help
if exist c:\DevEnv (
	echo ----------------------------------------------------------
	echo Uninstalling old components of DevEnv
	for /f %%i in ('dir /B c:\DevEnv\uninstall\*.exe') do ( 
		c:\DevEnv\uninstall\%%i /SP /VERYSILENT /SUPPRESSMSGBOXES /NORESTART
	)
	echo ----------------------------------------------------------
	echo Removing old DevEnv installation folder
	rmdir /Q /S c:\DevEnv >NUL 2>&1
)
set currpath=%cd%
echo ----------------------------------------------------------
echo Creating new DevEnv installation folder
mkdir c:\DevEnv
echo ----------------------------------------------------------
echo Installation of applications
cd Applications
echo              ---------------------------------------------
echo              Installation of libarchive     version 2.4.12
libarchive-2.4.12-setup.exe /SP /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /DIR="c:\DevEnv"
echo              ---------------------------------------------
echo              Installation of DaemonTools    version 4.48.1
DTLite4481-0347.exe /S /nogadget /path "c:\DevEnv\DTLite-4.48.1"
echo              ---------------------------------------------
echo              Installation of 7-zip          version 9.20
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
	msiexec /a 7z920-x64.msi /qn TARGETDIR=c:\DevEnv\7zip /l*v c:\DevEnv\7-zip-log.txt
) else (
	msiexec /a 7z920-x86.msi /qn TARGETDIR=c:\DevEnv\7zip /l*v c:\DevEnv\7-zip-log.txt
)
echo              ---------------------------------------------
echo              Installation of Python         version 3.4.0
msiexec /a python-3.4.0a3.msi /qn TARGETDIR=c:\DevEnv\Python /l*v c:\DevEnv\Python-log.txt
echo              ---------------------------------------------
echo              Installation of Notepad++      version 6.5
mkdir c:\DevEnv\NotePad
c:\DevEnv\7zip\Files\7-Zip\7z.exe x npp.6.5.bin.7z -oc:\DevEnv\NotePad >NUL
echo              ---------------------------------------------
echo              Installation of Cmake          version 2.8.11
c:\DevEnv\7zip\Files\7-Zip\7z.exe x cmake-2.8.11.2-win32-x86.zip -oc:\DevEnv > NUL
move c:\DevEnv\cmake-2.8.11.2-win32-x86 c:\DevEnv\Cmake-2.8.11 >NUL 2>&1
cd ..
echo ----------------------------------------------------------
echo Installation of 3rd party dependencies
cd 3rdParty
echo              ---------------------------------------------
echo              Installation of coreutils      version 5.3.0
coreutils-5.3.0.exe /SP /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /DIR="c:\DevEnv"
echo              ---------------------------------------------
echo              Installation of grep           version 2.5.4
grep-2.5.4-setup.exe /SP /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /DIR="c:\DevEnv"
echo              ---------------------------------------------
echo              Installation of gawk           version 3.1.6
gawk-3.1.6-setup.exe /SP /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /DIR="c:\DevEnv"
echo              ---------------------------------------------
echo              Installation of sed            version 4.2.1
sed-4.2.1-setup.exe /SP /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /DIR="c:\DevEnv"
echo              ---------------------------------------------
echo              Installation of gif libraries  version 4.1.4
libungif-4.1.4.exe /SP /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /DIR="c:\DevEnv"
echo              ---------------------------------------------
echo              Installation of tiff libraries version 3.8.2
tiff-3.8.2-1.exe /SP /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /DIR="c:\DevEnv"
cd ..
echo ----------------------------------------------------------
echo Removing temporary folder
rmdir /S /Q c:\DevEnv\tmp
echo ----------------------------------------------------------
echo Moving SetEnv executable to bin folder
copy SetEnv.exe c:\DevEnv\bin
echo ----------------------------------------------------------
echo Adding c:\DevEnv\bin to PATH
set "str=%PATH%"
if "!str:c:\DevEnv\bin=!" EQU "%str%" (
  	SetEnv -au PATH %%c:\DevEnv\bin
  )
echo ----------------------------------------------------------
echo Adding c:\DevEnv\7zip\Files\7-Zip to PATH 
if "!str:c:\DevEnv\7zip\Files\7-Zip=!" EQU "%str%" (
  	SetEnv -au PATH %%c:\DevEnv\7zip\Files\7-Zip
  )
echo ----------------------------------------------------------
echo Adding c:\DevEnv\Python to PATH 
if "!str:c:\DevEnv\Python=!" EQU "%str%" (
  	SetEnv -au PATH %%c:\DevEnv\Python
  )
echo ----------------------------------------------------------
echo Adding c:\DevEnv\NotePad to PATH 
if "!str:c:\DevEnv\NotePad=!" EQU "%str%" (
  	SetEnv -au PATH %%c:\DevEnv\NotePad
  )
echo ----------------------------------------------------------
echo Adding c:\DevEnv\Cmake\bin to PATH 
if "!str:c:\DevEnv\Cmake-2.8.11\bin=!" EQU "%str%" (
  	SetEnv -au PATH %%c:\DevEnv\Cmake-2.8.11\bin
  )
echo ----------------------------------------------------------
echo Adding c:\DevEnv\lib to LIBRARY_PATH 
if defined LIBRARY_PATH (
  set "str=%LIBRARY_PATH%"
  if "!str:c:\DevEnv\lib=!" EQU "%str%" (
  	SetEnv.exe -ua LIBRARY_PATH %%c:\DevEnv\lib
  )
) else (
  	SetEnv.exe -ua LIBRARY_PATH %%c:\DevEnv\lib
  	set "str=c:\DevEnv\lib"
)
echo ----------------------------------------------------------
echo Creating PYTHONPATH
if defined PYTHONPATH (
  SetEnv.exe -d PYTHONPATH
)
SetEnv.exe -ua PYTHONPATH c:\DevEnv\Python:c:\DevEnv\Python\DLLs:c:\DevEnv\Python\Lib:c:\DevEnv\Python\libs:c:\DevEnv\Python\tcl
echo ----------------------------------------------------------
echo Mounting Visual Express 2012 ISO
c:\DevEnv\DTLite-4.48.1\DTLite.exe -mount dt, 0,"z:\VS2012_WDX_FRA.iso"
echo ----------------------------------------------------------
echo. 
echo               END OF INSTALLATION SCRIPT
echo. 
echo               CLOSE THIS NATIVE COMMAND 
echo                EXECUTE NEXT STEPS IN A
echo                 VISUAL NATIF COMMAND
echo. 
goto end
:help
echo.
echo ----------------------------------------------------------
echo. 
echo createDevEnvVisual for Windows Seven Pro 64 Bits
echo Version : 2.1
echo Date : 07/10/2013
echo Author : Christian Schulte 
echo Creates the DevEnv for the Windows Seven PCs of the 
echo PycsHel prototyping bench using Visual C++ Express 2012.
echo. 
echo This programm will uninstall and erase any existing
echo program and variable of the old DevEnv.
:end
echo. 
echo ----------------------------------------------------------
echo. 

