
##############################################################################
# Try to find Contract related of LABSIM Development Environment
# Once done this will define:
#
#  LabsimContract_FOUND         - True requested libraries were found
#  LabsimContract_INCLUDE_DIRS  - LABSIM Common include directories
#  LabsimContract_LIBRARY_DIRS  - LABSIM Common directories for LABSIM Common libraries
#  LabsimContract_LIBRARIES     - LABSIM Common component libraries to be linked
#  LabsimContract_<C>_FOUND     - True if component <C> was found(<C> is upper-case)
#  LabsimContract_<C>_LIBRARY   - Link these to use specific Contract libraries . (<C> is upper-case)
#  LabsimContract_<C>_ROOT      - Corresponding root path i to <C>  component (<C> is upper-case)
#
##############################################################################

# set default 
set(LabsimContract_FOUND 1)       
set(LabsimContract_INCLUDE_DIRS)
set(LabsimContract_LIBRARY_DIRS)
set(LabsimContract_LIBRARIES)

# get a clean root path
if(DEFINED ENV{DEV_HOME}) 
    if(IS_DIRECTORY $ENV{DEV_HOME}/Contract)
        get_filename_component(_ROOTPATH $ENV{DEV_HOME}/Contract ABSOLUTE)
    else()
        message(FATAL_ERROR "ERROR: $ENV{DEV_HOME}/Contract directory doesn't exist !...")
    endif()
else()
    message(FATAL_ERROR "ERROR: Requested environment variables DEV_HOME doesn't exist !...")
endif()
   
# iterate over requested components
foreach(COMPONENT ${LabsimContract_FIND_COMPONENTS})

    # Uppercase them !
    string(TOUPPER ${COMPONENT} UPPERCOMPONENT)
    
    # test that library match requested scheme
    if(NOT IS_DIRECTORY ${_ROOTPATH}/${COMPONENT} OR NOT IS_DIRECTORY ${_ROOTPATH}/${COMPONENT}/include NOT IS_DIRECTORY ${_ROOTPATH}/${COMPONENT}/lib)
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
    
    # Add each lib to LabsimContract_<C>_LIBRARY
    file(GLOB_RECURSE LabsimContract_${UPPERCOMPONENT}_LIBRARY ${_${UPPERCOMPONENT}_LIBRARY_DIRS}/*)
    
    # Add each include/lib dir to LabsimContract_INCLUDE_DIRS/LabsimContract_LIBRARY_DIRS
    list(APPEND LabsimContract_INCLUDE_DIRS ${_${UPPERCOMPONENT}_INCLUDE_DIRS})
    list(APPEND LabsimContract_LIBRARY_DIRS ${_${UPPERCOMPONENT}_LIBRARY_DIRS})
        
    # Add LabsimContract_<C>_LIBRARY to LabsimContract_LIBRARIES
    list(APPEND LabsimContract_LIBRARIES ${LabsimContract_${UPPERCOMPONENT}_LIBRARY})
    
    # flag LabsimContract_<C>_FOUND
    set($LabsimContract_${UPPERCOMPONENT}_FOUND 1)
    
    # set root
    get_filename_component(LabsimContract_${UPPERCOMPONENT}_ROOT ${_ROOTPATH}/${COMPONENT}/ ABSOLUTE) 
    
endforeach()

# checkup => general LabsimContrat_FOUND + print
message(STATUS "Found the following LabsimContract libraries :")
foreach(COMPONENT ${LabsimContrat_FIND_COMPONENTS})

    # Uppercase them !
    string(TOUPPER ${COMPONENT} UPPERCOMPONENT)
    
    # print status
    if(${LabsimContrat_${UPPERCOMPONENT}_FOUND} EQUAL 1)
        message(STATUS "  ${COMPONENT} -> ${LabsimContract_${UPPERCOMPONENT}_LIBRARY}")
    else()
        message(STATUS "  ${COMPONENT}... component NOT found !")
    endif()
    
    # fill global
    if(NOT $LabsimContrat_FOUND EQUAL 0) 
        set($LabsimContrat_FOUND ${LabsimContrat_${UPPERCOMPONENT}_FOUND})
    endif()
    
endforeach()

# = EOF
