#!/bin/bash

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

#################################################
# pid.conf.sh
#
# attente d'un PID a la sauce LABSIM :)
#
# author : Schulte Christian
#

COLORCASE="10"

function switch_colorcase()
{
case "$COLORCASE" in
	"1")
		R='\033[0;33m'
		B='\033[0;35m'
		COLORCASE="2"
		;;
	"2")
		R='\033[0;34m'
		B='\033[0;33m'
		COLORCASE="3"
		;;
	"3")
		R='\033[0;33m'
		B='\033[0;34m'
		COLORCASE="4"
		;;
	"4")
		R='\033[0;34m'
		B='\033[0;31m'
		COLORCASE="5"
		;;
	"5")
		R='\033[0;31m'
		B='\033[0;34m'
		COLORCASE="6"
		;;
	"6")
		R='\033[0;32m'
		B='\033[0;31m'
		COLORCASE="7"
		;;
	"7")
		R='\033[0;31m'
		B='\033[0;32m'
		COLORCASE="8"
		;;
	"8")
		R='\033[0;32m'
		B='\033[0;35m'
		COLORCASE="9"
		;;
	"9")
		R='\033[0;35m'
		B='\033[0;32m'
		COLORCASE="10"
		;;
	"10")
		R='\033[0;35m'
		B='\033[0;33m'
		COLORCASE="1"
		;;
esac
}

###
# Fonction d'attente
function wait_for_PID() 
{
	echo " "	
	R='\033[0;35m'
	B='\033[0;33m'
	NC='\033[0m'
	IMAGENB="1"
	switch_colorcase
	while [[ ( -d /proc/$1 ) && ( -z `grep zombie /proc/$1/status` ) ]]; do
		case "$IMAGENB" in
		"1")
		echo -ne "\t${R} __         ______   _______    ______   ______  __       __ \n"
		echo -ne "\t|  \\       /      \\ |       \\  /      \\ |      \\|  \\     /  \\ \n"
		echo -ne "\t| ${B}SS${R}      |  ${B}SSSSSS${R}\\| ${B}SSSSSSS${R}\\|  ${B}SSSSSS${R}\\ \\ ${B}SSSSS${R}| ${B}SS${R}\\   /  ${B}SS${R}\n"
		echo -ne "\t| ${B}SS${R}      | ${B}SS${R}__| ${B}SS${R}| ${B}SS${R}__/ ${B}SS${R}| ${B}SS${R}___\\ ${B}S${R}  | ${B}SS${R}  | ${B}SSS${R}\\ /  ${B}SSS${R}\n"
		echo -ne "\t| ${B}SS${R}      | ${B}SS${R}    ${B}SS${R}| ${B}SS${R}    ${B}SS${R} \\ ${B}S${R}    \\   | ${B}SS${R}  | ${B}SSSS${R}\\  ${B}SSSS${R}\n"
		echo -ne "\t| ${B}SS${R}      | ${B}SSSSSSSS${NC}| ${B}SSSSSSS${R}\\ _\\ ${B}SSSSS${R}\\  | ${B}SS${R}  | ${B}SS${R}\\ ${B}S${R} ${B}SS${R} ${B}SS${R}\n"
		echo -ne "\t| ${B}SS${R}_____ | ${B}SS${R}  | ${B}SS${R}| ${B}SS${R}__/ ${B}SS${R}|  \\__| ${B}SS${R} _| ${B}SS${R}_ | ${B}SS${R} \\ ${B}SS${R}| ${B}SS${R}\n"
		echo -ne "\t| ${B}SS${R}     \\| ${B}SS${R}  | ${B}SS${R}| ${B}SS${R}    ${B}SS${R} \\ ${B}S${R}    ${B}SS${R}|   ${B}SS${R} \\| ${B}SS${R}  \\ ${B}S${R}| ${B}SS${R}\n"
		echo -ne "\t \\ ${B}SSSSSSS${R} \\ ${B}S${R}   \\ ${B}S${R} \\ ${B}SSSSSS${R}   \\ ${B}SSSSS${R}  \\ ${B}SSSSS${R} \\ ${B}S${R}      \\ ${B}S${R}\n"
		IMAGENB="2"
		switch_colorcase
		;;
		"2")
		echo -ne "\t${R} __         ______   _______    ______   ______  __       __ \n"
		echo -ne "\t/  |       /      \\ /       \\  /      \\ /      |/  \\     /  |\n"
		echo -ne "\t${B}SS${R} |      /${B}SSSSSS${R}  |${B}SSSSSSS${R}  |/${B}SSSSSS${R}  |${B}SSSSSS${R}/ ${B}SS${R}  \\   /${B}SS${R} |\n"
		echo -ne "\t${B}SS${R} |      ${B}SS${R} |__${B}SS${R} |${B}SS${R} |__${B}SS${R} |${B}SS${R} \\__${B}SS${R}/   ${B}SS${R} |  ${B}SSS${R}  \\ /${B}SSS${R} |\n"
		echo -ne "\t${B}SS${R} |      ${B}SS${R}    ${B}SS${R} |${B}SS${R}    ${B}SS${R}< ${B}SS${R}      \\   ${B}SS${R} |  ${B}SSSS${R}  /${B}SSSS${R} |\n"
		echo -ne "\t${B}SS${R} |      ${B}SSSSSSSS${R} |${B}SSSSSSS${R}  | ${B}SSSSSS${R}  |  ${B}SS${R} |  ${B}SS${R} ${B}SS${R} ${B}SS${R}/${B}SS${R} |\n"
		echo -ne "\t${B}SS${R} |_____ ${B}SS${R} |  ${B}SS${R} |${B}SS${R} |__${B}SS${R} |/  \\__${B}SS${R} | _${B}SS${R} |_ ${B}SS |${B}SSS${R}/ ${B}SS${R} |\n"
		echo -ne "\t${B}SS${R}       |${B}SS${R} |  ${B}SS${R} |${B}SS${R}    ${B}SS${R}/ ${B}SS${R}    ${B}SS${R}/ / ${B}SS   |${B}SS | ${B}S${R}/  ${B}SS${R} |\n"
		echo -ne "\t${B}SSSSSSSS${R}/ ${B}SS${R}/   ${B}SS${R}/ ${B}SSSSSSS${R}/   ${B}SSSSSS${R}/  ${B}SSSSSS${R}/ ${B}SS${R}/      ${B}SS${R}/ \n"
		IMAGENB="3"
		switch_colorcase
		;;
		"3")
		echo -ne "\t${R}__         ______   _______    ______   ______  __       __  \n"
		echo -ne "\t${B}SS${R}\\        ${B}SSSSSS${R}\\  ${B}SSSSSSS${R}\\   ${B}SSSSSS${R}\\  ${B}SSSSSS${R}\\ ${B}SS${R}\\      ${B}SS${R} \\ \n"
		echo -ne "\t${B}SS${R} |      ${B}SS${R}  __${B}SS${R}\\ ${B}SS${R}  __${B}SS${R}\\ ${B}SS${R}  __${B}SS${R}\\ \\_${B}SS${R}  _|${B}SSS${R}\\    ${B}SSS${R} |\n"
		echo -ne "\t${B}SS${R} |      ${B}SS${R} /  ${B}SS${R} |${B}SS${R} |  ${B}SS${R} |${B}SS${R} /  \\__|  ${B}SS${R} |  ${B}SSSS${R}\\  ${B}SSSS${R} |\n"
		echo -ne "\t${B}SS${R} |      ${B}SSSSSSSS${R} |${B}SSSSSSS${R}\\ |\\ ${B}SSSSS${R}\\    ${B}SS${R} |  ${B}SS${R}\\ ${B}S${R}\\ ${B}S${R} ${B}SS${R} |\n"
		echo -ne "\t${B}SS${R} |      ${B}SS${R}  __${B}SS${R} |${B}SS${R}  __${B}SS${R}\\  \\____${B}SS${R}\\   ${B}SS${R} |  ${B}SS${R} \\ ${B}SS${R}  ${B}SS${R} |\n"
		echo -ne "\t${B}SS${R} |      ${B}SS${R} |  ${B}SS${R} |${B}SS${R} |  ${B}SS${R} |${B}SS${R}\\   ${B}SS${R} |  ${B}SS${R} |  ${B}SS${R} |\\ ${B}S${R} /${B}SS${R} |\n"
		echo -ne "\t${B}SSSSSSSS${R}\ ${B}SS${R} |  ${B}SS${R} |${B}SSSSSSS${R}  |\\ ${B}SSSSS${R}  |${B}SSSSSS${R}\\ ${B}SS${R} | \\_/ ${B}SS${R} |\n"
		echo -ne "\t\\________|\\__|  \\__|\\_______/  \\______/ \\______|\\__|     \\__|\n"
		IMAGENB="4"
		switch_colorcase
		;;
		"4")
		echo -ne "\t${R}  __         ______   _______    ______   ______  __       __\n"
		echo -ne "\t /${B}SS${R}        /${B}SSSSSS${R}  /${B}SSSSSSS${R}   /${B}SSSSSS${R}  /${B}SSSSSS${R} /${B}SS${R}      /${B}SS${R}\n"
		echo -ne "\t| ${B}SS${R}       /${B}SS${R}__  ${B}SS${R}| ${B}SS${R}__  ${B}SS${R} /${B}SS${R}__  ${B}SS${R}|_  ${B}SS${R}_/| ${B}SSS${R}    /${B}SSS${R}\n"
		echo -ne "\t| ${B}SS${R}      | ${B}SS${R}  \\ ${B}SS${R}| ${B}SS${R}  \\ ${B}SS${R}| ${B}SS${R}  \\__/  | ${B}SS${R}  | ${B}SSSS${R}  /${B}SSSS${R}\n"
		echo -ne "\t| ${B}SS${R}      | ${B}SSSSSSSS${R}| ${B}SSSSSSS${R} |  ${B}SSSSSS${R}   | ${B}SS${R}  | ${B}SS${R} ${B}SS${R}/${B}SS${R} ${B}SS${R}\n"
		echo -ne "\t| ${B}SS${R}      | ${B}SS${R}__  ${B}SS${R}| ${B}SS${R}__  ${B}SS${R} \\____  ${B}SS${R}  | ${B}SS${R}  | ${B}SS${R}  ${B}SSS${R}| ${B}SS${R}\n"
		echo -ne "\t| ${B}SS${R}      | ${B}SS${R}  | ${B}SS${R}| ${B}SS${R}  \\ ${B}SS${R} /${B}SS${R}  \\ ${B}SS${R}  | ${B}SS${R}  | ${B}SS${R}\\  ${B}S${R} | ${B}SS${R}\n"
		echo -ne "\t| ${B}SSSSSSSS${R}| ${B}SS${R}  | ${B}SS${R}| ${B}SSSSSSS${R}/|  ${B}SSSSSS${R}/ /${B}SSSSSS${R}| ${B}SS${R} \\/  | ${B}SS${R}\n"
		echo -ne "\t|________/|__/  |__/|_______/  \\______/ |______/|__/     |__/\n"
		IMAGENB="1"
		switch_colorcase
		;;
		esac
		echo -ne "\033[9A"
		sleep 0.15
	done
	echo -ne "\033[9B ${NC}"
}

return 0
# == EOF
