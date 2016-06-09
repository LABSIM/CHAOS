@echo off&SetLocal EnableDelayedExpansion
rem
rem ----------------------------------------------------------
rem 
rem install_cegui.bat for Windows Seven Pro 64 Bits
rem Version : 1.2
rem Date : 18/12/2013
rem Author : Christian Schulte 
rem Configures and installs CEGui 0.8.2 and its dependencies
rem
rem ----------------------------------------------------------
rem 
echo.
echo ----------------------------------------------------------
echo.
echo Install of CEGui 0.8.2
if not exist c:\DevEnv (
	echo. 
	echo ----------------------------------------------------------
	echo Please execute first createDevEnvVisual.bat
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
echo ----------------------------------------------------------
echo Extraction of CEGui dependencies            version 0.8.x
cd 3rdParty
7z.exe x -y cegui-deps-0.8.x-src.zip -oc:\DevEnv > NUL
cd ..
echo ----------------------------------------------------------
echo Configuration of CEGui dependencies         version 0.8.x
c:
cd c:\DevEnv\cegui-deps-0.8.x-src
cmake -Wno-dev -DCMAKE_INSTALL_PREFIX=c:\DevEnv\CEGui-deps ^
 -G "Visual Studio 11" ^
 -DCMAKE_CONFIGURATION_TYPES=Release ^
 -DCEGUI_BUILD_CORONA=TRUE ^
 -DCEGUI_BUILD_DEVIL=FALSE ^
 -DCEGUI_BUILD_EFFECTS11=FALSE ^
 -DCEGUI_BUILD_EXPAT=TRUE ^
 -DCEGUI_BUILD_FREEIMAGE=TRUE ^
 -DCEGUI_BUILD_FREETYPE2=TRUE ^
 -DCEGUI_BUILD_GLEW=TRUE ^
 -DCEGUI_BUILD_GLFW=TRUE ^
 -DCEGUI_BUILD_GLM=TRUE ^
 -DCEGUI_BUILD_LUA=TRUE ^
 -DCEGUI_BUILD_MINIZIP=TRUE ^
 -DCEGUI_BUILD_PCRE=TRUE ^
 -DCEGUI_BUILD_SILLY=TRUE ^
 -DCEGUI_BUILD_TINYXML=TRUE ^
 -DCEGUI_BUILD_TOLUAPP=TRUE ^
 -DCEGUI_BUILD_XERCES=TRUE ^
 -DCEGUI_BUILD_ZLIB=TRUE ^
 . > c:\DevEnv\cegui_deps_cmake.log 2>&1
echo ----------------------------------------------------------
cd ..
echo Please compile in Release with Visual
echo Press any key to continue...
pause
echo ----------------------------------------------------------
echo Extraction of CEGui                         version 0.8.2
z:
cd Applications
7z.exe x -y cegui-0.8.2.zip -oc:\DevEnv > NUL
cd ..
c:
cd c:\DevEnv
mv cegui-0.8.2 cegui_inst
echo ----------------------------------------------------------
echo Modification du fichier CEGUISamplesConfig.h.in
sed -i -e "46,48d" c:\DevEnv\cegui_inst\samples\common\include\CEGUISamplesConfig.h.in
sed -i -e "47d" c:\DevEnv\cegui_inst\samples\common\include\CEGUISamplesConfig.h.in
echo ----------------------------------------------------------
echo Configuration of CEGui                      version 0.8.2
cd cegui_inst
cmake -Wno-dev -DCMAKE_INSTALL_PREFIX=c:\DevEnv\CEGui-0.8.2 ^
 -G "Visual Studio 11" ^
 -DCMAKE_CONFIGURATION_TYPES=Release ^
 -DPCRE_H_PATH=c:\DevEnv\cegui-deps-0.8.x-src\dependencies\include ^
 -DFREETYPE_H_PATH_ft2build=c:\DevEnv\cegui-deps-0.8.x-src\dependencies\include ^
 -DFREETYPE_H_PATH_ftconfig=c:\DevEnv\cegui-deps-0.8.x-src\dependencies\include\freetype\config ^
 -DMINIZIP_H_PATH=c:\DevEnv\cegui-deps-0.8.x-src\dependencies\include\minizip ^
 -DGLEW_H_PATH=c:\DevEnv\cegui-deps-0.8.x-src\dependencies\include ^
 -DGLM_H_PATH=c:\DevEnv\cegui-deps-0.8.x-src\dependencies\include ^
 -DGLFW_H_PATH=c:\DevEnv\cegui-deps-0.8.x-src\dependencies\include ^
 -DEXPAT_H_PATH=c:\DevEnv\cegui-deps-0.8.x-src\dependencies\include ^
 -DXERCESC_H_PATH=c:\DevEnv\cegui-deps-0.8.x-src\dependencies\include ^
 -DTINYXML_H_PATH=c:\DevEnv\cegui-deps-0.8.x-src\dependencies\include ^
 -DFREEIMAGE_H_PATH=c:\DevEnv\cegui-deps-0.8.x-src\dependencies\include ^
 -DSILLY_H_PATH=c:\DevEnv\cegui-deps-0.8.x-src\dependencies\include ^
 -DCORONA_H_PATH=c:\DevEnv\cegui-deps-0.8.x-src\dependencies\include ^
 -DLUA_H_PATH=c:\DevEnv\cegui-deps-0.8.x-src\dependencies\include ^
 -DTOLUAPP_H_PATH=c:\DevEnv\cegui-deps-0.8.x-src\dependencies\include ^
 -DPCRE_LIB=C:\DevEnv\cegui-deps-0.8.x-src\dependencies\lib\dynamic\pcre.lib ^
 -DFREETYPE_LIB=C:\DevEnv\cegui-deps-0.8.x-src\dependencies\lib\dynamic\freetype.lib ^
 -DMINIZIP_LIB=C:\DevEnv\cegui-deps-0.8.x-src\dependencies\lib\dynamic\minizip.lib ^
 -DGLEW_LIB=C:\DevEnv\cegui-deps-0.8.x-src\dependencies\lib\dynamic\glew.lib ^
 -DGLFW_LIB=C:\DevEnv\cegui-deps-0.8.x-src\dependencies\lib\dynamic\glfw.lib ^
 -DEXPAT_LIB=C:\DevEnv\cegui-deps-0.8.x-src\dependencies\lib\dynamic\expat.lib ^
 -DXERCESC_LIB=C:\DevEnv\cegui-deps-0.8.x-src\dependencies\lib\dynamic\xerces-c_3.lib ^
 -DTINYXML_LIB=C:\DevEnv\cegui-deps-0.8.x-src\dependencies\lib\dynamic\tinyxml.lib ^
 -DFREEIMAGE_LIB=C:\DevEnv\cegui-deps-0.8.x-src\dependencies\lib\dynamic\FreeImage.lib ^
 -DSILLY_LIB=C:\DevEnv\cegui-deps-0.8.x-src\dependencies\lib\dynamic\SILLY.lib ^
 -DCORONA_LIB=C:\DevEnv\cegui-deps-0.8.x-src\dependencies\lib\dynamic\corona.lib ^
 -DLUA_LIB=C:\DevEnv\cegui-deps-0.8.x-src\dependencies\lib\dynamic\lua.lib ^
 -DTOLUAPP_LIB=C:\DevEnv\cegui-deps-0.8.x-src\dependencies\lib\dynamic\toluapp.lib ^
 -DPCRE_LIB_STATIC=C:\DevEnv\cegui-deps-0.8.x-src\dependencies\lib\static\pcre.lib ^
 -DFREETYPE_LIB_STATIC=C:\DevEnv\cegui-deps-0.8.x-src\dependencies\lib\static\freetype.lib ^
 -DMINIZIP_LIB_STATIC=C:\DevEnv\cegui-deps-0.8.x-src\dependencies\lib\static\minizip.lib ^
 -DGLEW_LIB_STATIC=C:\DevEnv\cegui-deps-0.8.x-src\dependencies\lib\static\glew.lib ^
 -DGLFW_LIB_STATIC=C:\DevEnv\cegui-deps-0.8.x-src\dependencies\lib\static\glfw.lib ^
 -DEXPAT_LIB_STATIC=C:\DevEnv\cegui-deps-0.8.x-src\dependencies\lib\static\expat.lib ^
 -DXERCESC_LIB_STATIC=C:\DevEnv\cegui-deps-0.8.x-src\dependencies\lib\static\xerces-c_3.lib ^
 -DTINYXML_LIB_STATIC=C:\DevEnv\cegui-deps-0.8.x-src\dependencies\lib\static\tinyxml.lib ^
 -DFREEIMAGE_LIB_STATIC=C:\DevEnv\cegui-deps-0.8.x-src\dependencies\lib\static\FreeImage.lib ^
 -DSILLY_LIB_STATIC=C:\DevEnv\cegui-deps-0.8.x-src\dependencies\lib\static\SILLY.lib ^
 -DCORONA_LIB_STATIC=C:\DevEnv\cegui-deps-0.8.x-src\dependencies\lib\static\corona.lib ^
 -DLUA_LIB_STATIC=C:\DevEnv\cegui-deps-0.8.x-src\dependencies\lib\static\lua.lib ^
 -DTOLUAPP_LIB_STATIC=C:\DevEnv\cegui-deps-0.8.x-src\dependencies\lib\static\toluapp.lib ^
 -DPYTHON_EXECUTABLE=c:\DevEnv\Python\python.exe ^
 -DPYTHON_LIBRARY=c:\DevEnv\Python\libs\python34.lib ^
 -DPYTHON_INCLUDE_DIR=c:\DevEnv\Python\include ^
 -DCEGUI_BUILD_XMLPARSER_TINYXML=TRUE ^
 -DCEGUI_BUILD_XMLPARSER_XERCES=TRUE ^
 -DCEGUI_BUILD_XMLPARSER_EXPAT=TRUE ^
 -DCEGUI_OPTION_DEFAULT_IMAGECODEC="FreeImageImageCodec" ^
 -DCEGUI_OPTION_DEFAULT_XMLPARSER="ExpatParser" ^
 -DCEGUI_BUILD_IMAGECODEC_CORONA=TRUE ^
 -DCEGUI_BUILD_IMAGECODEC_FREEIMAGE=TRUE ^
 -DCEGUI_BUILD_IMAGECODEC_SILLY=TRUE ^
 -DCEGUI_BUILD_LUA_GENERATOR=TRUE ^
 -DCEGUI_BUILD_LUA_MODULE=TRUE ^
 -DCEGUI_BUILD_PYTHON_MODULES=TRUE ^
 -DCEGUI_BUILD_RENDERER_OPENGL=TRUE ^
 -DCEGUI_BUILD_RENDERER_OPENGL3=TRUE ^
 -DCEGUI_HAS_FREETYPE=TRUE ^
 -DCEGUI_HAS_MINIZIP_RESOURCE_PROVIDER=FALSE ^
 -DCEGUI_HAS_PCRE_REGEX=TRUE ^
 -DCEGUI_SAMPLES_ENABLED=TRUE ^
 -DCEGUI_SAMPLES_USE_OPENGL=TRUE ^
 -DCEGUI_SAMPLES_USE_OPENGL3=TRUE ^
 -DBoost_DIR=c:\DevEnv\Boost-1.53.0 ^
 -DBoost_LIBRARY_DIR=c:\DevEnv\Boost-1.53.0\lib ^
 -DBoost_INCLUDE_DIR=c:\DevEnv\Boost-1.53.0\include\boost-1_53 ^
 . > c:\DevEnv\cegui_cmake.log 2>&1
echo ----------------------------------------------------------
echo Modification of Shader.h and ShaderManager.h
rem Dans ces deux fichiers, il manque les décoration Windows permettant l'export des symboles dans la lib.
rem Pour chacun on ajoute donc l'include contenant la définition et la définition sur la déclaration des classes.
sed -i -e "/#include <string>/a #include \"CEGUI/RendererModules/OpenGL/RendererBase.h\"" c:\DevEnv\cegui_inst\cegui\include\CEGUI\RendererModules\OpenGL\Shader.h
sed -i -e "s/class OpenGL3Shader :/class OPENGL_GUIRENDERER_API OpenGL3Shader :/g" c:\DevEnv\cegui_inst\cegui\include\CEGUI\RendererModules\OpenGL\Shader.h
sed -i -e "/#include <string>/a #include \"CEGUI/RendererModules/OpenGL/RendererBase.h\"" c:\DevEnv\cegui_inst\cegui\include\CEGUI\RendererModules\OpenGL\ShaderManager.h
sed -i -e "s/class OpenGL3ShaderManager :/class OPENGL_GUIRENDERER_API OpenGL3ShaderManager :/g" c:\DevEnv\cegui_inst\cegui\include\CEGUI\RendererModules\OpenGL\ShaderManager.h
echo ----------------------------------------------------------
echo Please compile and install in Release with Visual
echo Press any key to continue...
pause
cd ..
z:
echo ----------------------------------------------------------
echo Copy dependencies to install folder
mv C:\DevEnv\cegui-deps-0.8.x-src\dependencies C:\DevEnv\CEGui-0.8.2
echo ----------------------------------------------------------
echo Remove temporary folders
rm -rf c:\DevEnv\cegui_inst
rm -rf c:\DevEnv\cegui-deps-0.8.x-src
echo ----------------------------------------------------------
echo Adding c:\DevEnv\CEGui-0.8.2\bin to PATH
set "str=%PATH%"
if "!str:c:\DevEnv\CEGui-0.8.2\bin=!" EQU "%str%" (
  	SetEnv -au PATH %%c:\DevEnv\CEGui-0.8.2\bin
)
echo ----------------------------------------------------------
echo Adding c:\DevEnv\CEGui-0.8.2\lib to PATH
if "!str:c:\DevEnv\CEGui-0.8.2\lib=!" EQU "%str%" (
  	SetEnv -au PATH %%c:\DevEnv\CEGui-0.8.2\lib
)
echo ----------------------------------------------------------
echo Adding c:\DevEnv\CEGui-0.8.2\bin to LIBRARY_PATH
set "str=%LIBRARY_PATH%"
if "!str:c:\DevEnv\CEGui-0.8.2\bin=!" EQU "%str%" (
  	SetEnv -au LIBRARY_PATH %%c:\DevEnv\CEGui-0.8.2\bin
)
echo ----------------------------------------------------------
echo Adding c:\DevEnv\CEGui-0.8.2\lib to LIBRARY_PATH
if "!str:c:\DevEnv\CEGui-0.8.2\lib=!" EQU "%str%" (
  	SetEnv -au LIBRARY_PATH %%c:\DevEnv\CEGui-0.8.2\lib
)
echo ----------------------------------------------------------
echo Adding c:\DevEnv\CEGui-0.8.2\dependencies\bin to PATH
set "str=%PATH%"
if "!str:c:\DevEnv\CEGui-0.8.2\dependencies\bin=!" EQU "%str%" (
  	SetEnv -au PATH %%c:\DevEnv\CEGui-0.8.2\dependencies\bin
)
echo ----------------------------------------------------------
echo Adding c:\DevEnv\CEGui-0.8.2\dependencies\lib\static to PATH
if "!str:c:\DevEnv\CEGui-0.8.2\dependencies\lib\static=!" EQU "%str%" (
  	SetEnv -au PATH %%c:\DevEnv\CEGui-0.8.2\dependencies\lib\static
)
echo ----------------------------------------------------------
echo Adding c:\DevEnv\CEGui-0.8.2\dependencies\lib\dynamic to PATH
if "!str:c:\DevEnv\CEGui-0.8.2\dependencies\lib\dynamic=!" EQU "%str%" (
  	SetEnv -au PATH %%c:\DevEnv\CEGui-0.8.2\dependencies\lib\dynamic
)
echo ----------------------------------------------------------
echo Adding c:\DevEnv\CEGui-0.8.2\dependencies\bin to LIBRARY_PATH
set "str=%LIBRARY_PATH%"
if "!str:c:\DevEnv\CEGui-0.8.2\dependencies\bin=!" EQU "%str%" (
  	SetEnv -au LIBRARY_PATH %%c:\DevEnv\CEGui-0.8.2\dependencies\bin
)
echo ----------------------------------------------------------
echo Adding c:\DevEnv\CEGui-0.8.2\dependencies\lib\static to LIBRARY_PATH
if "!str:c:\DevEnv\CEGui-0.8.2\dependencies\lib\static=!" EQU "%str%" (
  	SetEnv -au LIBRARY_PATH %%c:\DevEnv\CEGui-0.8.2\dependencies\lib\static
)
echo ----------------------------------------------------------
echo Adding c:\DevEnv\CEGui-0.8.2\dependencies\lib\dynamic to LIBRARY_PATH
if "!str:c:\DevEnv\CEGui-0.8.2\dependencies\lib\dynamic=!" EQU "%str%" (
  	SetEnv -au LIBRARY_PATH %%c:\DevEnv\CEGui-0.8.2\dependencies\lib\dynamic
)
:end
echo. 
echo ----------------------------------------------------------
echo. 
