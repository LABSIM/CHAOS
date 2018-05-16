#!/usr/bin/env bash

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

# all credits goes here :) thanks guys
# -> [ https://stackoverflow.com/questions/64786/error-handling-in-bash ]
# -> [ https://github.com/anordal/shellharden/blob/master/how_to_do_things_safely_in_bash.md ]


lib_name="GAIA"
lib_version="1.0.0"
stderr_log="/tmp/GAIA/$(whoami)/${0##*/}-$(date +%s).log"

#
# TO BE SOURCED ONLY ONCE:
#
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##

if test "${g_libs[$lib_name]+_}"; then
    return 0
else
    if test ${#g_libs[@]} == 0; then
        declare -A g_libs
    fi
    g_libs[$lib_name]=$lib_version
fi

#
# MAIN CODE:
#
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##

# shell standard configuration
if test "$BASH" = "" || "$BASH" -uc 'a=();true "${a[@]}"' 2>/dev/null; then

	# Bash 4.4, Zsh
	set -euo pipefail # trace ERR through pipes
	set -o errtrace   # trace ERR through 'time command' and other functions
	set -o nounset    ## set -u : exit the script if you try to use an uninitialised variable
	set -o errexit    ## set -e : exit the script if any statement returns a non-true return value

else

	# Bash 4.3 and older chokes on empty arrays with set -u.
	set -eo pipefail # trace ERR through pipes
	set -o errtrace  # trace ERR through 'time command' and other functions
	set -o nounset   ## set -u : exit the script if you try to use an uninitialised variable
	set -o errexit   ## set -e : exit the script if any statement returns a non-true return value

fi
shopt -s nullglob globstar
exec 2>"$stderr_log"

###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##

function die() 
{ 
    echo "$@" 1>&2 ;
    exit 1; 
}

function exit_on_error()
{
    if [[ -z "$1" ]]; then

        die "parameter must be set"

    fi

    if ($1); then

        #enable log to file, set flags, set traps
        exec 2>"$stderr_log"
        set -o nounset
        set -o errexit
        trap exit_handler EXIT 
        trap exit ERR 

    else

        #enable log to STDERR, reset flags, reset traps
        exec 2>&1
        set +o nounset
        set +o errexit
        trap - EXIT ERR 

    fi
}

###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
#
# FUNCTION: EXIT_HANDLER
#
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##

function exit_handler ()
{
    local error_code="$?"

    test $error_code == 0 && return;

    #
    # LOCAL VARIABLES:
    # ------------------------------------------------------------------
    #    
    local i=0
    local regex=''
    local mem=''

    local error_file=''
    local error_lineno=''
    local error_message='unknown'

    local lineno=''


    #
    # PRINT THE HEADER:
    # ------------------------------------------------------------------
    #
    # Color the output if it's an interactive terminal
    test -t 1 && tput bold; tput setf 4                                 ## red bold
    echo -e "\n(!) EXIT HANDLER:\n"


    #
    # GETTING LAST ERROR OCCURRED:
    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

    #
    # Read last file from the error log
    # ------------------------------------------------------------------
    #
    if test -f "$stderr_log"
        then
            stderr=$( tail -n 1 "$stderr_log" )
    fi

    #
    # Managing the line to extract information:
    # ------------------------------------------------------------------
    #

    if test -n "$stderr"
        then        
            # Exploding stderr on :
            mem="$IFS"
            local shrunk_stderr=$( echo "$stderr" | sed 's/\: /\:/g' )
            IFS=':'
            local stderr_parts=( $shrunk_stderr )
            IFS="$mem"

            if ((${#stderr_parts[@]} > 1)); then

                # Storing information on the error
                error_file="${stderr_parts[0]}"
                error_lineno="${stderr_parts[1]}"
                error_message=""

                for (( i = 3; i <= ${#stderr_parts[@]}; i++ ))
                    do
                        error_message="$error_message "${stderr_parts[$i-1]}": "
                done

                # Removing last ':' (colon character)
                error_message="${error_message%:*}"

                # Trim
                error_message="$( echo "$error_message" | sed -e 's/^[ \t]*//' | sed -e 's/[ \t]*$//' )"
            else
                error_message=$stderr
            fi
    fi

    #
    # GETTING BACKTRACE:
    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
    _backtrace=$( backtrace 2 )

    #
    # MANAGING THE OUTPUT:
    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

    local lineno=""
    regex='^([a-z]{1,}) ([0-9]{1,})$'

    if [[ $error_lineno =~ $regex ]]

        # The error line was found on the log
        # (e.g. type 'ff' without quotes wherever)
        # --------------------------------------------------------------
        then
            local row="${BASH_REMATCH[1]}"
            lineno="${BASH_REMATCH[2]}"

            echo -e "FILE:\t\t${error_file}"
            echo -e "${row^^}:\t\t${lineno}\n"

            echo -e "ERROR CODE:\t${error_code}"             
            test -t 1 && tput setf 6                                    ## white yellow
            echo -e "ERROR MESSAGE:\n$error_message"


        else
            regex="^${error_file}\$|^${error_file}\s+|\s+${error_file}\s+|\s+${error_file}\$"
            if [[ "$_backtrace" =~ $regex ]]

                # The file was found on the log but not the error line
                # (could not reproduce this case so far)
                # ------------------------------------------------------
                then
                    echo -e "FILE:\t\t$error_file"
                    echo -e "ROW:\t\tunknown\n"

                    echo -e "ERROR CODE:\t${error_code}"
                    test -t 1 && tput setf 6                            ## white yellow
                    echo -e "ERROR MESSAGE:\n${stderr}"

                # Neither the error line nor the error file was found on the log
                # (e.g. type 'cp ffd fdf' without quotes wherever)
                # ------------------------------------------------------
                else
                    #
                    # The error file is the first on backtrace list:

                    # Exploding backtrace on newlines
                    mem=$IFS
                    IFS='
                    '
                    #
                    # Substring: I keep only the carriage return
                    # (others needed only for tabbing purpose)
                    IFS=${IFS:0:1}
                    local lines=( $_backtrace )

                    IFS=$mem

                    error_file=""

                    if test -n "${lines[1]}"
                        then
                            array=( ${lines[1]} )

                            for (( i=2; i<${#array[@]}; i++ ))
                                do
                                    error_file="$error_file ${array[$i]}"
                            done

                            # Trim
                            error_file="$( echo "$error_file" | sed -e 's/^[ \t]*//' | sed -e 's/[ \t]*$//' )"
                    fi

                    echo -e "FILE:\t\t$error_file"
                    echo -e "ROW:\t\tunknown\n"

                    echo -e "ERROR CODE:\t${error_code}"
                    test -t 1 && tput setf 6                            ## white yellow
                    if test -n "${stderr}"
                        then
                            echo -e "ERROR MESSAGE:\n${stderr}"
                        else
                            echo -e "ERROR MESSAGE:\n${error_message}"
                    fi
            fi
    fi

    #
    # PRINTING THE BACKTRACE:
    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

    test -t 1 && tput setf 7                                            ## white bold
    echo -e "\n$_backtrace\n"

    echo "Error log is here: $stderr_log"

    #
    # EXITING:
    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

    test -t 1 && tput setf 4                                            ## red bold
    echo "Exiting!"

    test -t 1 && tput sgr0 # Reset terminal

    exit "$error_code"
}

trap exit_handler EXIT                                                  # ! ! ! TRAP EXIT ! ! !
trap exit ERR                                                           # ! ! ! TRAP ERR ! ! !


###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
#
# FUNCTION: BACKTRACE
#
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##

function backtrace
{
    local _start_from_=0

    local params=( "$@" )
    if (( "${#params[@]}" >= "1" ))
        then
            _start_from_="$1"
    fi

    local i=0
    local first=false
    while caller $i > /dev/null
    do
        if test -n "$_start_from_" && (( "$i" + 1   >= "$_start_from_" ))
            then
                if test "$first" == false
                    then
                        echo "BACKTRACE IS:"
                        first=true
                fi
                caller $i
        fi
        let "i=i+1"
    done
}

return 0
