
##############################################################################
# Try to find Titans related lib of LABSIM Development Environment
# Once done this will define:
#
#  LabsimTitans_FOUND         - True requested libraries were found
#  LabsimTitans_INCLUDE_DIRS  - LABSIM Common include directories
#  LabsimTitans_LIBRARY_DIRS  - LABSIM Common directories for LABSIM Common libraries
#  LabsimTitans_LIBRARIES     - LABSIM Common component libraries to be linked
#  LabsimTitans_<C>_FOUND     - True if component <C> was found(<C> is upper-case)
#  LabsimTitans_<C>_LIBRARY   - Link these to use specific Titans libraries . (<C> is upper-case)
#  LabsimTitans_<C>_ROOT      - Corresponding root path i to <C>  component (<C> is upper-case)
#
##############################################################################

# set default 
set(LabsimTitans_FOUND 1)       
set(LabsimTitans_INCLUDE_DIRS "")
set(LabsimTitans_LIBRARY_DIRS "")
set(LabsimTitans_LIBRARIES "")

# get a clean root path
if(DEFINED ENV{DEV_HOME}) 
    if(IS_DIRECTORY $ENV{DEV_HOME}/Titans)
        get_filename_component(_ROOTPATH $ENV{DEV_HOME}/Titans ABSOLUTE)
    else()
        message(FATAL_ERROR "ERROR: $ENV{DEV_HOME}/Titans directory doesn't exist !...")
    endif()
else()
    message(FATAL_ERROR "ERROR: Requested environment variables DEV_HOME doesn't exist !...")
endif()
   
# iterate over requested components
foreach(COMPONENT ${LabsimTitans_FIND_COMPONENTS})

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
    
    # Add each lib to LabsimTitans_<C>_LIBRARY
    file(GLOB_RECURSE LabsimTitans_${UPPERCOMPONENT}_LIBRARY ${_${UPPERCOMPONENT}_LIBRARY_DIRS}/*)
    
    # Add each include/lib dir to LabsimTitans_INCLUDE_DIRS/LabsimTitans_LIBRARY_DIRS
    list(APPEND LabsimTitans_INCLUDE_DIRS ${_${UPPERCOMPONENT}_INCLUDE_DIRS})
    list(APPEND LabsimTitans_LIBRARY_DIRS ${_${UPPERCOMPONENT}_LIBRARY_DIRS})
        
    # Add LabsimTitans_<C>_LIBRARY to LabsimTitans_LIBRARIES
    list(APPEND LabsimTitans_LIBRARIES ${LabsimTitans_${UPPERCOMPONENT}_LIBRARY})
    
    # flag LabsimTitans_<C>_FOUND
    set(LabsimTitans_${UPPERCOMPONENT}_FOUND 1)
    
    # set root
    get_filename_component(LabsimTitans_${UPPERCOMPONENT}_ROOT ${_ROOTPATH}/${COMPONENT}/ ABSOLUTE)
    
endforeach()

# checkup => general LabsimTitans_FOUND + print
message(STATUS "Found the following LabsimTitans libraries :")
foreach(COMPONENT ${LabsimTitans_FIND_COMPONENTS})

    # Uppercase them !
    string(TOUPPER ${COMPONENT} UPPERCOMPONENT)
    
    # print status
    if(${LabsimTitans_${UPPERCOMPONENT}_FOUND} EQUAL 1)
        message(STATUS "  ${COMPONENT} ${LabsimTitans_${UPPERCOMPONENT}_LIBRARY}")
    else()
        message(STATUS "  ${COMPONENT}... component NOT found !")
    endif()
    
    # fill global
    if(NOT $LabsimTitans_FOUND EQUAL 0) 
        set($LabsimTitans_FOUND ${LabsimTitans_${UPPERCOMPONENT}_FOUND})
    endif()
    
endforeach()

# = EOF