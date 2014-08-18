
##############################################################################
# Try to find Colosse related lib of LABSIM Development Environment
# Once done this will define:
#
#  LabsimColosse_FOUND         - True requested libraries were found
#  LabsimColosse_INCLUDE_DIRS  - LABSIM Common include directories
#  LabsimColosse_LIBRARY_DIRS  - LABSIM Common directories for LABSIM Common libraries
#  LabsimColosse_LIBRARIES     - LABSIM Common component libraries to be linked
#  LabsimColosse_<C>_FOUND     - True if component <C> was found(<C> is upper-case)
#  LabsimColosse_<C>_LIBRARY   - Link these to use OpenSplice. (<C> is upper-case)
#
##############################################################################

# set default 
set(LabsimColosse_FOUND 1)       
set(LabsimColosse_INCLUDE_DIRS)
set(LabsimColosse_LIBRARY_DIRS)
set(LabsimColosse_LIBRARIES)

# get a clean root path
if(DEFINED ENV{DEV_ROOT}) 
    if(IS_DIRECTORY $ENV{DEV_ROOT}/Colosse)
        get_filename_component(_ROOTPATH $ENV{DEV_ROOT}/Colosse ABSOLUTE)
    else()
        message(FATAL_ERROR "ERROR: $ENV{DEV_ROOT}/Colosse directory doesn't exist !...")
    endif()
else()
    message(FATAL_ERROR "ERROR: Requested environment variables DEV_ROOT doesn't exist !...")
endif()
   
# iterate over requested components
foreach(COMPONENT ${LabsimColosse_FIND_COMPONENTS})

    # Uppercase them !
    string(TOUPPER ${COMPONENT} UPPERCOMPONENT)
    
    # test that library match requested scheme
    if(NOT IS_DIRECTORY ${_ROOTPATH}/${COMPONENT} OR NOT IS_DIRECTORY ${_ROOTPATH}/${COMPONENT}/include OR NOT IS_DIRECTORY ${_ROOTPATH}/${COMPONENT}/lib)
        message(FATAL_ERROR "ERROR: Requested coponents ${COMPONENT} doesn't match requested include/lib scheme !...")
    endif()
    
    # Add each lib to LabsimColosse_<C>_LIBRARY
    file(GLOB_RECURSE LabsimColosse_${UPPERCOMPONENT}_LIBRARY ${_ROOTPATH}/${COMPONENT}/lib/*)
    
    # Add each include/lib dir to LabsimColosse_INCLUDE_DIRS/LabsimColosse_LIBRARY_DIRS
    list(APPEND LabsimColosse_INCLUDE_DIRS ${_ROOTPATH}/${COMPONENT}/include)
    list(APPEND LabsimColosse_LIBRARY_DIRS ${_ROOTPATH}/${COMPONENT}/lib)
    
    # Add LabsimColosse_<C>_LIBRARY to LabsimColosse_LIBRARIES
    list(APPEND LabsimColosse_LIBRARIES ${LabsimColosse_${UPPERCOMPONENT}_LIBRARY})
    
    # flag LabsimColosse_<C>_FOUND
    set(LabsimColosse_${UPPERCOMPONENT}_FOUND 1)
    
endforeach()

# checkup => general LabsimColosse_FOUND + print
message(STATUS "-- LabsimColosse component(s) found :")
foreach(COMPONENT ${LabsimColosse_FIND_COMPONENTS})

    # Uppercase them !
    string(TOUPPER ${COMPONENT} UPPERCOMPONENT)
    
    # print status
    if(${LabsimColosse_${UPPERCOMPONENT}_FOUND} EQUAL 1)
        message(STATUS "-- \t requested ${COMPONENT} component found")
    else()
        message(STATUS "-- \t requested ${COMPONENT} component NOT found !")
    endif()
    
    # fill global
    if(NOT $LabsimColosse_FOUND EQUAL 0) 
        set($LabsimColosse_FOUND ${LabsimColosse_${UPPERCOMPONENT}_FOUND})
    endif()
    
endforeach()

# = EOF
