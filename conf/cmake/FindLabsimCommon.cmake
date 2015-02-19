
##############################################################################
# Try to find Common related lib of LABSIM Development Environment
# Once done this will define:
#
#  LabsimCommon_FOUND         - True requested libraries were found
#  LabsimCommon_INCLUDE_DIRS  - LABSIM Common include directories
#  LabsimCommon_LIBRARY_DIRS  - LABSIM Common directories for LABSIM Common libraries
#  LabsimCommon_LIBRARIES     - LABSIM Common component libraries to be linked
#  LabsimCommon_<C>_FOUND     - True if component <C> was found(<C> is upper-case)
#  LabsimCommon_<C>_LIBRARY   - Link these to use specific Common libraries . (<C> is upper-case)
#  LabsimCommon_<C>_ROOT      - Corresponding root path i to <C>  component (<C> is upper-case)
#
##############################################################################

# set default 
set(LabsimCommon_FOUND 1)       
set(LabsimCommon_INCLUDE_DIRS "")
set(LabsimCommon_LIBRARY_DIRS "")
set(LabsimCommon_LIBRARIES "")

# get a clean root path
if(DEFINED ENV{DEV_HOME}) 
    get_filename_component(_ROOTPATH $ENV{DEV_HOME} ABSOLUTE)
else()
    message(FATAL_ERROR "ERROR: Requested environment variables DEV_HOME doesn't exist !...")
endif()
   
# iterate over requested components
foreach(COMPONENT ${LabsimCommon_FIND_COMPONENTS})

    # Uppercase them !
    string(TOUPPER ${COMPONENT} UPPERCOMPONENT)
    
    # test that library match requested scheme
    if(NOT IS_DIRECTORY ${_ROOTPATH}/${COMPONENT} OR NOT IS_DIRECTORY ${_ROOTPATH}/${COMPONENT}/include OR NOT IS_DIRECTORY ${_ROOTPATH}/${COMPONENT}/lib)
        message(FATAL_ERROR "ERROR: Requested components ${COMPONENT} doesn't match requested include/lib scheme...")
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
    
    # Add each lib to LabsimCommon_<C>_LIBRARY
    file(GLOB_RECURSE LabsimCommon_${UPPERCOMPONENT}_LIBRARY ${_${UPPERCOMPONENT}_LIBRARY_DIRS}/*)
    
    # Add each include/lib dir to LabsimCommon_INCLUDE_DIRS/LabsimCommon_LIBRARY_DIRS
    list(APPEND LabsimCommon_INCLUDE_DIRS ${_${UPPERCOMPONENT}_INCLUDE_DIRS})
    list(APPEND LabsimCommon_LIBRARY_DIRS ${_${UPPERCOMPONENT}_LIBRARY_DIRS})
        
    # Add LabsimCommon_<C>_LIBRARY to LabsimCommon_LIBRARIES
    list(APPEND LabsimCommon_LIBRARIES ${LabsimCommon_${UPPERCOMPONENT}_LIBRARY})
    
    # flag LabsimCommon_<C>_FOUND
    set(LabsimCommon_${UPPERCOMPONENT}_FOUND 1)
    
    # set root
    get_filename_component(LabsimCommon_${UPPERCOMPONENT}_ROOT ${_ROOTPATH}/${COMPONENT}/ ABSOLUTE)
    
endforeach()

# checkup => general LabsimCommon_FOUND + print
message(STATUS "Found the following LabsimCommon libraries :")
foreach(COMPONENT ${LabsimCommon_FIND_COMPONENTS})

    # Uppercase them !
    string(TOUPPER ${COMPONENT} UPPERCOMPONENT)
    
    # print status
    if(${LabsimCommon_${UPPERCOMPONENT}_FOUND} EQUAL 1)
        message(STATUS "  ${COMPONENT}")
    else()
        message(STATUS "  ${COMPONENT}... component NOT found !")
    endif()
    
    # fill global
    if(NOT $LabsimCommon_FOUND EQUAL 0) 
        set($LabsimCommon_FOUND ${LabsimCommon_${UPPERCOMPONENT}_FOUND})
    endif()
    
endforeach()

# = EOF
