# Find TRITON toolkit
# This module defines
# TRITON_FOUND
# TRITON_INCLUDE_DIR
# On windows:
#   TRITON_LIBRARY_DEBUG
#   TRITON_LIBRARY_RELEASE
# On other platforms
#   TRITON_LIBRARY
#


IF (MSVC90)
	IF (CMAKE_CL_64)
		SET(TRITON_ARCH "vc9/x64")
	ELSE (CMAKE_CL_64)
		SET(TRITON_ARCH "vc9/win32")
	ENDIF (CMAKE_CL_64)
ENDIF (MSVC90)

IF (MSVC80)
	IF (CMAKE_CL_64)
		SET(TRITON_ARCH "vc8/x64")
	ELSE (CMAKE_CL_64)
		SET(TRITON_ARCH "vc8/win32")
	ENDIF (CMAKE_CL_64)
ENDIF (MSVC80)

IF (MSVC10)
	IF (CMAKE_CL_64)
		SET(TRITON_ARCH "vc10/x64")
	ELSE (CMAKE_CL_64)
		SET(TRITON_ARCH "vc10/win32")
	ENDIF (CMAKE_CL_64)
ENDIF (MSVC10)

IF (MSVC11)
	IF (CMAKE_CL_64)
		SET(TRITON_ARCH "vc11/x64")
	ELSE (CMAKE_CL_64)
		SET(TRITON_ARCH "vc11/win32")
	ENDIF (CMAKE_CL_64)
ENDIF (MSVC11)

IF (MSVC71)
	SET(TRITON_ARCH "vc7")
ENDIF (MSVC71)

IF (MSVC60)
	SET(TRITON_ARCH "vc6")
ENDIF (MSVC60)

IF (UNIX)
	SET(TRITON_ARCH "linux")
ENDIF (UNIX)

FIND_PATH(TRITON_INCLUDE_DIR Triton.h
    "${TRITON_DIR}/Public Headers"
    "$ENV{TRITON_PATH}/Public Headers"
    $ENV{TRITON_PATH}
    ${TRITON_DIR}/include
    $ENV{TRITON_DIR}/include
    $ENV{TRITON_DIR}
    /usr/local/include
    /usr/include
    /sw/include # Fink
    /opt/local/include # DarwinPorts
    /opt/csw/include # Blastwave
    /opt/include
    /usr/freeware/include
)

MACRO(FIND_TRITON_LIBRARY MYLIBRARY MYLIBRARYNAME)

    FIND_LIBRARY(${MYLIBRARY}
    NAMES ${MYLIBRARYNAME}
    PATHS
		${TRITON_DIR}/lib
		$ENV{TRITON_DIR}/lib
		$ENV{TRITON_DIR}
		$ENV{TRITON_PATH}/lib
		/usr/local/lib
		/usr/lib
		/sw/lib
		/opt/local/lib
		/opt/csw/lib
		/opt/lib
		/usr/freeware/lib64
	PATH_SUFFIXES
		${TRITON_ARCH}
    )

ENDMACRO(FIND_TRITON_LIBRARY MYLIBRARY MYLIBRARYNAME)


FIND_TRITON_LIBRARY(TRITON_LIBRARY_RELEASE "Triton-MT-DLL;Triton")
FIND_TRITON_LIBRARY(TRITON_LIBRARY_DEBUG "Triton-MTD-DLL;Triton")

SET(TRITON_FOUND FALSE)
IF (TRITON_INCLUDE_DIR AND TRITON_LIBRARY_RELEASE AND TRITON_LIBRARY_DEBUG)
   SET(TRITON_FOUND TRUE)
ENDIF (TRITON_INCLUDE_DIR AND TRITON_LIBRARY_RELEASE AND TRITON_LIBRARY_DEBUG)

IF (TRITON_FOUND)
   IF (NOT TRITON_FIND_QUIETLY)
      MESSAGE(STATUS "Found Triton: ${TRITON_LIBRARY_RELEASE}")
   ENDIF (NOT TRITON_FIND_QUIETLY)
ELSE (TRITON_FOUND)
   IF (TRITON_FIND_REQUIRED)
      MESSAGE(FATAL_ERROR "Could not find Triton")
   ENDIF (TRITON_FIND_REQUIRED)
ENDIF (TRITON_FOUND)
