
##############################################################################
# Try to find Contract related of LABSIM Development Environment
# Once done this will define:
#
#  LabsimContract_FOUND         - True requested libraries were found
#  LabsimContract_INCLUDE_DIRS  - LABSIM Common include directories
#  LabsimContract_LIBRARY_DIRS  - LABSIM Common directories for LABSIM Common libraries
#  LabsimContract_LIBRARIES     - LABSIM Common component libraries to be linked
#  LabsimContract_<C>_FOUND     - True if component <C> was found(<C> is upper-case)
#  LabsimContract_<C>_LIBRARY   - Link these to use OpenSplice. (<C> is upper-case)
#
##############################################################################

# set default 
set(LabsimContract_FOUND 1)       
set(LabsimContract_INCLUDE_DIRS)
set(LabsimContract_LIBRARY_DIRS)
set(LabsimContract_LIBRARIES)

# get a clean root path
if(DEFINED ENV{DEV_ROOT}) 
    if(IS_DIRECTORY $ENV{DEV_ROOT}/Contract)
        get_filename_component(_ROOTPATH $ENV{DEV_ROOT}/Contract ABSOLUTE)
    else()
        message(FATAL_ERROR "ERROR: $ENV{DEV_ROOT}/Contract directory doesn't exist !...")
    endif()
else()
    message(FATAL_ERROR "ERROR: Requested environment variables DEV_ROOT doesn't exist !...")
endif()
   
# iterate over requested components
foreach(COMPONENT ${LabsimContract_FIND_COMPONENTS})

    # Uppercase them !
    string(TOUPPER ${COMPONENT} UPPERCOMPONENT)
    
    # test that library match requested scheme
    if(NOT IS_DIRECTORY ${_ROOTPATH}/${COMPONENT} OR NOT IS_DIRECTORY ${_ROOTPATH}/${COMPONENT}/include NOT IS_DIRECTORY ${_ROOTPATH}/${COMPONENT}/lib)
        message(FATAL_ERROR "ERROR: Requested coponents ${COMPONENT} doesn't match requested include/lib scheme !...")
    endif()
    
    # Add each lib to LabsimContract_<C>_LIBRARY
    file(GLOB_RECURSE LabsimContract_${UPPERCOMPONENT}_LIBRARY ${_ROOTPATH}/${COMPONENT}/lib/*)
    
    # Add each include/lib dir to LabsimContract_INCLUDE_DIRS/LabsimContract_LIBRARY_DIRS
    list(APPEND LabsimContract_INCLUDE_DIRS ${_ROOTPATH}/${COMPONENT}/include)
    list(APPEND LabsimContract_LIBRARY_DIRS ${_ROOTPATH}/${COMPONENT}/lib)
    
    # Add LabsimContract_<C>_LIBRARY to LabsimContract_LIBRARIES
    list(APPEND LabsimContract_LIBRARIES ${LabsimContract_${UPPERCOMPONENT}_LIBRARY})
    
    # flag LabsimContract_<C>_FOUND
    set($LabsimContract_${UPPERCOMPONENT}_FOUND 1)
    
endforeach()

# checkup => general LabsimContract_FOUND
foreach(COMPONENT ${LabsimContract_FIND_COMPONENTS})
    if(NOT $LabsimContract_FOUND EQUAL 0) 
        set($LabsimContract_FOUND ${LabsimContract_${UPPERCOMPONENT}_FOUND})
    endif()
endforeach()

# = EOF
