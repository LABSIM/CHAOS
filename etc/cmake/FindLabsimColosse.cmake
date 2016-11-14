#
# GAIA : required LABSIM ground software ecosystem
# Copyright (C) 2012-2016  Nawfel KINANI
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; see the file COPYING.
# If not, see <http://www.gnu.org/licenses/>.
#

##############################################################################
# Try to find Colosse related lib of LABSIM Development Environment
# Once done this will define:
#
#  LabsimColosse_FOUND         - True requested libraries were found
#  LabsimColosse_INCLUDE_DIRS  - LABSIM Common include directories
#  LabsimColosse_LIBRARY_DIRS  - LABSIM Common directories for LABSIM Common libraries
#  LabsimColosse_LIBRARIES     - LABSIM Common component libraries to be linked
#  LabsimColosse_<C>_FOUND     - True if component <C> was found(<C> is upper-case)
#  LabsimColosse_<C>_LIBRARY   - Link these to use specific Colosse libraries . (<C> is upper-case)
#  LabsimColosse_<C>_ROOT      - Corresponding root path i to <C>  component (<C> is upper-case)
#
##############################################################################

# set default 
set(LabsimColosse_FOUND 1)       
set(LabsimColosse_INCLUDE_DIRS)
set(LabsimColosse_LIBRARY_DIRS)
set(LabsimColosse_LIBRARIES)

# get a clean root path
if(DEFINED ENV{DEV_HOME}) 
    if(IS_DIRECTORY $ENV{DEV_HOME}/Colosse)
        get_filename_component(_ROOTPATH $ENV{DEV_HOME}/Colosse ABSOLUTE)
    else()
        message(FATAL_ERROR "ERROR: $ENV{DEV_HOME}/Colosse directory doesn't exist !...")
    endif()
else()
    message(FATAL_ERROR "ERROR: Requested environment variables DEV_HOME doesn't exist !...")
endif()
   
# iterate over requested components
foreach(COMPONENT ${LabsimColosse_FIND_COMPONENTS})

    # Uppercase them !
    string(TOUPPER ${COMPONENT} UPPERCOMPONENT)
    
    # test that library match requested scheme
    if(NOT IS_DIRECTORY ${_ROOTPATH}/${COMPONENT} OR NOT IS_DIRECTORY ${_ROOTPATH}/${COMPONENT}/include OR NOT IS_DIRECTORY ${_ROOTPATH}/${COMPONENT}/lib)
        message(FATAL_ERROR "ERROR: Requested coponents ${COMPONENT} doesn't match requested include/lib scheme !...")
    endif()
    
    # be careful about system config
    if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
    
        # set MSVC internal
        set(_${UPPERCOMPONENT}_INCLUDE_DIRS ${_ROOTPATH}/${COMPONENT}/include)
        set(_${UPPERCOMPONENT}_LIBRARY_DIRS ${_ROOTPATH}/${COMPONENT}/lib/$(ConfigurationName))
        
    else()
    
        # set GCC internal
        set(_${UPPERCOMPONENT}_INCLUDE_DIRS ${_ROOTPATH}/${COMPONENT}/include)
        set(_${UPPERCOMPONENT}_LIBRARY_DIRS ${_ROOTPATH}/${COMPONENT}/lib)
               
    endif() 
    
    # Add each lib to LabsimColosse_<C>_LIBRARY
    file(GLOB_RECURSE LabsimColosse_${UPPERCOMPONENT}_LIBRARY ${_${UPPERCOMPONENT}_LIBRARY_DIRS}/*)
    
    # Add each include/lib dir to LabsimColosse_INCLUDE_DIRS/LabsimColosse_LIBRARY_DIRS
    list(APPEND LabsimColosse_INCLUDE_DIRS ${_${UPPERCOMPONENT}_INCLUDE_DIRS})
    list(APPEND LabsimColosse_LIBRARY_DIRS ${_${UPPERCOMPONENT}_LIBRARY_DIRS})
        
    # Add LabsimColosse_<C>_LIBRARY to LabsimColosse_LIBRARIES
    list(APPEND LabsimColosse_LIBRARIES ${LabsimColosse_${UPPERCOMPONENT}_LIBRARY})
        
    # flag LabsimColosse_<C>_FOUND
    set(LabsimColosse_${UPPERCOMPONENT}_FOUND 1)
    
    # set root
    get_filename_component(LabsimColosse_${UPPERCOMPONENT}_ROOT ${_ROOTPATH}/${COMPONENT} ABSOLUTE)
    
endforeach()

# checkup => general LabsimColosse_FOUND + print
message(STATUS "Found the following LabsimColosse libraries :")
foreach(COMPONENT ${LabsimColosse_FIND_COMPONENTS})

    # Uppercase them !
    string(TOUPPER ${COMPONENT} UPPERCOMPONENT)
    
    # print status
    if(${LabsimColosse_${UPPERCOMPONENT}_FOUND} EQUAL 1)
        message(STATUS "  ${COMPONENT} -> ${LabsimColosse_${UPPERCOMPONENT}_LIBRARY}")
    else()
        message(STATUS "  ${COMPONENT}... component NOT found !")
    endif()
    
    # fill global
    if(NOT $LabsimColosse_FOUND EQUAL 0) 
        set($LabsimColosse_FOUND ${LabsimColosse_${UPPERCOMPONENT}_FOUND})
    endif()
    
endforeach()

# = EOF
