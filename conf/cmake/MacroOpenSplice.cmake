#
# Initialize procedure definition 
# -------------------------------
# initialize variables onto internal scope
#
macro(ospl_initalize_procedure idlfilename)
    
    # User defined variables
    if(NOT DEFINED OpenSplice_IDLGEN_LANG)
        message(STATUS "La variable OpenSplice_IDLGEN_LANG n'a pas été défini. (valeur par defaut : cpp)")
        set(OpenSplice_IDLGEN_LANG "cpp" CACHE STRINGS "Le language dans lequel les fichiers seront générés par le compilateur IDL DDS")
    endif(NOT DEFINED OpenSplice_IDLGEN_LANG)
    if(NOT DEFINED OpenSplice_IDLGEN_OPT)
        message(STATUS "La variable OpenSplice_IDLGEN_OPT n'a pas été défini. (valeur par defaut : -S)")
        set(OpenSplice_IDLGEN_OPT "-S" CACHE STRINGS "Les options de compilation du compilateur IDL DDS")
    endif(NOT DEFINED OpenSplice_IDLGEN_OPT)
   
    # Variables
    set(tmp_idlpath)
    set(tmp_idlfilename)
    set(tmp_incl)
    set(tmp_idlname)
    set(tmp_idlgenfiles)
    set(tmp_src)
    set(tmp_header)
    set(tmp_target) 
    
    # Initialize them
    get_filename_component(tmp_idlfilename ${idlfilename} NAME)       # extract idl filename
    get_filename_component(tmp_idlname ${idlfilename} NAME_WE)	      # extract idl name only
	get_filename_component(tmp_idlpath ${idlfilename} PATH)           # cut idl filename
	get_filename_component(tmp_idlpath ${tmp_idlpath}/../ ABSOLUTE)   # get up once to point to idl/ root
	set(tmp_target "${tmp_idlname}_IDL")                              # target name
	
endmacro(ospl_initalize_procedure idlfilename)

#
# Extract procedure definition
# ----------------------------
# list future generated source files because of a well known output generation pattern
#
macro(ospl_list_generated_src_procedure)
	
	# create the header & src list
	set(tmp_header
	    ${tmp_idlpath}/tmp/${tmp_idlname}.h 
	    ${tmp_idlpath}/tmp/${tmp_idlname}Dcps.h
	    ${tmp_idlpath}/tmp/${tmp_idlname}Dcps_impl.h
	    ${tmp_idlpath}/tmp/${tmp_idlname}SplDcps.h
	    ${tmp_idlpath}/tmp/ccpp_${tmp_idlname}.h
	)
	
	set(tmp_src
	    ${tmp_idlpath}/tmp/${tmp_idlname}.cpp 
	    ${tmp_idlpath}/tmp/${tmp_idlname}Dcps.cpp 
	    ${tmp_idlpath}/tmp/${tmp_idlname}Dcps_impl.cpp 
	    ${tmp_idlpath}/tmp/${tmp_idlname}SplDcps.cpp
	)
	
	list(APPEND tmp_idlgenfiles ${tmp_header} ${tmp_src})
	
endmacro(ospl_list_generated_src_procedure)

#
# Processing procedure defintion
# ------------------------------
# pre-process target source files & generate output
#
macro(ospl_process_generated_src_procedure)
	
	# Prepare cmd line arg
	string(REPLACE ";" " -I " tmp_incl ${OpenSplice_INCLUDE_DIRS})
	set(tmp_incl 
	    ${tmp_incl} 
	    -I ${tmp_idlpath}/mdl
    )
	
	# Prepare folders
	file(MAKE_DIRECTORY ${tmp_idlpath}/tmp)
	set_directory_properties(PROPERTIES ADDITIONAL_MAKE_CLEAN_FILES "${tmp_idlpath}/tmp;${tmp_idlpath}/src;${tmp_idlpath}/include")
	
	# Create a custom target
	add_custom_target("${tmp_target}" ALL)
	
	# Win32 Compilation rules
	if(WIN32)
	    set(tmp_dll_export -P DDS_API_EXPORT,${KRONOSDDS_ROOT}/include/KronosDDS/system/KronosDDSSys_Export.hpp)
	else()
	    set(tmp_dll_export)
	endif(WIN32)
	
	# Custom command
	add_custom_command(
	    PRE_BUILD
		COMMAND ${OpenSplice_IDLGEN_BINARY}
		ARGS -l ${OpenSplice_IDLGEN_LANG} -I ${tmp_incl} ${tmp_dll_export} -d ${tmp_idlpath}/tmp ${OpenSplice_IDLGEN_OPT} ${tmp_idlpath}/mdl/${tmp_idlfilename}
		DEPENDS ${tmp_idlpath}/mdl/${tmp_idlfilename}
		TARGET "${tmp_target}"
	)
	
	# Generate
	add_custom_command(
	    PRE_BUILD
		TARGET "${tmp_target}"
	    DEPENDS ${tmp_idlgenfiles}
    )
    
endmacro(ospl_process_generated_src_procedure)

#
# Dispatch procedure definition
# -----------------------------
# Dispatch generated source files 
#
macro(ospl_dispatch_generated_src_procedure)

    # Dispatch files
    foreach(header ${tmp_header})
        get_filename_component(header ${header} NAME)
        add_custom_command(
            TARGET "${tmp_target}" 
            PRE_BUILD 
            COMMAND ${CMAKE_COMMAND} -E copy ${tmp_idlpath}/tmp/${header} ${tmp_idlpath}/include/${header}
        )
    endforeach(header ${tmp_header})
    
    foreach(src ${tmp_src})
        get_filename_component(src ${src} NAME)
        add_custom_command(
            TARGET "${tmp_target}" 
            PRE_BUILD 
            COMMAND ${CMAKE_COMMAND} -E copy ${tmp_idlpath}/tmp/${src} ${tmp_idlpath}/src/${src}
        )
    endforeach(src ${tmp_src})
    
    add_custom_command(
        TARGET "${tmp_target}" 
        PRE_BUILD 
        COMMAND ${CMAKE_COMMAND} -E remove_directory ${tmp_idlpath}/tmp
    )
    
endmacro(ospl_dispatch_generated_src_procedure)

#
# Scoped procedure definition
# ---------------------------
# extract variables out of internal scope
#
macro(ospl_scoped_procedure)

    # Extract path
    set(OpenSplice_IDLGEN_PATH ${tmp_idlpath})
    message("Liste des headers & src générés pour la cible ${tmp_target}:\n\t > ${OpenSplice_IDLGEN_PATH}")
    
    # Extract headers 
    message("\t\t/include")
    foreach(headerfullpath ${tmp_header})
        get_filename_component(headerfullpath ${headerfullpath} NAME)
        set(OpenSplice_IDLGEN_HEADER ${OpenSplice_IDLGEN_HEADER} "${OpenSplice_IDLGEN_PATH}/include/${headerfullpath}")
        message("\t\t\t${headerfullpath}")
    endforeach(headerfullpath ${tmp_header})
    
    # Extract srcs 
    message("\t\t/src")
    foreach(srcfullpath ${tmp_src})
        get_filename_component(srcfullpath ${srcfullpath} NAME)
        set(OpenSplice_IDLGEN_SRC ${OpenSplice_IDLGEN_SRC} "${OpenSplice_IDLGEN_PATH}/src/${srcfullpath}")
        message("\t\t\t${srcfullpath}")
    endforeach(srcfullpath ${tmp_src})
    
endmacro(ospl_scoped_procedure)

#
# Closure procedure definition
# ----------------------------
# unset internal variable to keep a clean (& safe) behaviour
#
macro(ospl_closure_procedure)

    # unset
    unset(tmp_idlpath)
    unset(tmp_idlfilename)
    unset(tmp_incl)
    unset(tmp_idlname)
    unset(tmp_idlgenfiles)
    unset(tmp_src)
    unset(tmp_header)
    unset(tmp_target) 
    
endmacro(ospl_closure_procedure)

#
# Main procedure
# --------------
# compile sources files for a given .idl filename
#
macro(OSPL_GENERATE_IDL idlfilename)
	
	# Proceed
	ospl_initalize_procedure(${ARGV})
	ospl_list_generated_src_procedure()
	ospl_process_generated_src_procedure()
	ospl_dispatch_generated_src_procedure()
	ospl_scoped_procedure()
	ospl_closure_procedure()
	
endmacro(OSPL_GENERATE_IDL idlfilename)

#
# Dependence procedure
# --------------
# glue target with idl
#
macro(OSPL_MAKE_DEPEND idlfilename targetname)
	
	# variables
	set(tmp_target_idl)
	get_filename_component(tmp_target_idl ${idlfilename} NAME_WE)
	
	# assign
	foreach(dependencies ${targetname})
         add_dependencies("${dependencies}" "${tmp_target_idl}_IDL")
    endforeach(dependencies ${targetname})
    
    # unset
    unset(tmp_target_idl)	
    
endmacro(OSPL_MAKE_DEPEND idlfilename targetname)


